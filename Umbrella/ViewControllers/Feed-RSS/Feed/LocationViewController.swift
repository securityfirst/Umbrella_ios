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
    @IBOutlet weak var spaceBottomConstraint: NSLayoutConstraint!
    var placeHolderLabel: UILabel!
    var country: Country!
    
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
        self.locationText.delegate = self
        self.locationText.becomeFirstResponder()
        
        
        self.placeHolderLabel = UILabel(frame: locationText.bounds)
        self.placeHolderLabel.numberOfLines = 0
        self.placeHolderLabel.font = UIFont(name: "Helvetica", size: 14)
        self.placeHolderLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.placeHolderLabel.lineBreakMode = .byWordWrapping
        self.placeHolderLabel.text = "Enter the country you want to see the feed for".localized()
        self.locationText.addSubview(placeHolderLabel)
        
        self.saveButton.setTitle("Save".localized(), for: .normal)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Keyboard notification when change the frame
    ///
    /// - Parameter notification: NSNotification
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.spaceBottomConstraint?.constant = 25.0
                UIView.animate(withDuration: duration,
                               delay: 0,
                               options: animationCurve,
                               animations: { self.view.layoutIfNeeded() },
                               completion: nil)
            } else {
                self.spaceBottomConstraint?.constant = (endFrame?.size.height)! - 40
            }
        }
    }
    
    /// Save place
    ///
    /// - Parameter country: Country
    fileprivate func savePlace(_ country: Country) {
        NotificationCenter.default.post(name: Notification.Name("UpdateLocation"), object: nil, userInfo: ["location": (city: country.name, country: country.name, countryCode: country.codeAlpha2)])
        UserDefaults.standard.set(country.name, forKey: "LocationCity")
        UserDefaults.standard.set(country.name, forKey: "LocationCountry")
        UserDefaults.standard.set(country.codeAlpha2, forKey: "LocationCountryCode")
        NotificationCenter.default.post(name: Notification.Name("ContinueWizard"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    //
    // MARK: - Actions
    
    @IBAction func saveAction(_ sender: Any) {
        if self.locationViewModel.cityArray.count > 0 {
            if let country = self.country {
                savePlace(country)
            } else {
                UIApplication.shared.keyWindow!.makeToast("Please select one country of the list.".localized(), duration: 3.0, position: .center)
            }
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
            
            self.placeHolderLabel.isHidden = (updatedText.count != 0)
            
            if updatedText.count == 0 {
                self.locationViewModel.cityArray.removeAll()
            } else {
                self.locationViewModel.searchCountry(name: updatedText)
            }
            
            self.cityTableView.reloadData()
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
        
        let country = self.locationViewModel.cityArray[indexPath.row]
        cell.textLabel?.text = country.name
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.country = self.locationViewModel.cityArray[indexPath.row]
        self.locationText.text = self.country.name
    }
}
