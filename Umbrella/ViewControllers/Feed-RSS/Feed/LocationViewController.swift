//
//  LocationViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 06/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    
    //
    // MARK: - Properties
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    lazy var locationViewModel: LocationViewModel = {
        let locationViewModel = LocationViewModel()
        return locationViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Location".localized()
        self.locationText.setBottomBorder()
        self.locationText.placeholder = "Enter location".localized()
        self.locationText.delegate = self
        self.locationText.becomeFirstResponder()
        self.saveButton.setTitle("Save".localized(), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Show error
    fileprivate func showError() {
        UIAlertController.alert(title: "Alert".localized(), message: "The city or country is not available or you have no internet connection.".localized(), cancelButtonTitle: "OK", otherButtons: nil, dismiss: { _ in
            // Don't need to do nothing
        }, cancel: {
            // In this case we need to do nothing when user cancel the alert
            print("cancelClicked")
        })
    }
    
    /// Save place
    ///
    /// - Parameter placeMark: CLPlacemark
    fileprivate func savePlace(_ placeMark: CLPlacemark) {
        if let city = placeMark.name, let country = placeMark.country, let countryCode = placeMark.isoCountryCode {
            if city.lowercased() == self.locationText.text?.lowercased() {
                NotificationCenter.default.post(name: Notification.Name("UpdateLocation"), object: nil, userInfo: ["location": (city: city, country: country, countryCode: countryCode)])
                UserDefaults.standard.set(city, forKey: "LocationCity")
                UserDefaults.standard.set(country, forKey: "LocationCountry")
                UserDefaults.standard.set(countryCode, forKey: "LocationCountryCode")
                NotificationCenter.default.post(name: Notification.Name("ContinueWizard"), object: nil)
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showError()
            }
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func saveAction(_ sender: Any) {
        if self.locationViewModel.cityArray.count > 0 {
            if let placemark = self.locationViewModel.cityArray.first {
                savePlace(placemark)
            }
        } else {
            self.locationViewModel.geocode(of: self.locationText.text!, completion: {
                self.cityTableView.reloadData()
                if let placemark = self.locationViewModel.cityArray.first {
                    self.savePlace(placemark)
                }
            }, failure: {
                self.showError()
            })
        }
    }
}

//
// MARK: - UITextFieldDelegate
extension LocationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.locationText.layer.shadowColor = #colorLiteral(red: 0.262745098, green: 0.6274509804, blue: 0.7921568627, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.locationText.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if updatedText.count >= 3 {
                self.locationViewModel.geocode(of: updatedText, completion: {
                    self.cityTableView.reloadData()
                }, failure: {
                    // It is not necessary show alert in this case
                })
            } else {
                self.locationViewModel.cityArray.removeAll()
                self.cityTableView.reloadData()
            }
        }
        
        return true
    }
}

// MARK: - UITableViewDataSource
extension LocationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationViewModel.cityArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
        let location = self.locationViewModel.cityArray[indexPath.row]
        
        if let city = location.name, let country = location.country {
            cell.textLabel?.text = "\(city) \(country)"
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let city = self.locationViewModel.cityArray[indexPath.row]
        let cityString = "\(String(describing: city.name!))"
        
        self.locationText.text = cityString
    }
}
