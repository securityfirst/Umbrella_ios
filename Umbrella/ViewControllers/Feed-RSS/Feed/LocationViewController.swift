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
    
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    lazy var locationViewModel: LocationViewModel = {
        let locationViewModel = LocationViewModel()
        return locationViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationText.setBottomBorder()
        locationText.placeholder = "Enter location".localized()
        locationText.delegate = self
        locationText.becomeFirstResponder()
        saveButton.setTitle("Save".localized(), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Actions
    @IBAction func saveAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        NotificationCenter.default.post(name: Notification.Name("UpdateLocation"), object: nil, userInfo: ["location": locationText.text ?? ""])
    }
    
}

//
// MARK: - UITextFieldDelegate
extension LocationViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        locationText.layer.shadowColor = #colorLiteral(red: 0.262745098, green: 0.6274509804, blue: 0.7921568627, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        locationText.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if updatedText.count >= 3 {
                self.locationViewModel.geocode(of: updatedText) { 
                    self.cityTableView.reloadData()
                }
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
        
        let city = self.locationViewModel.cityArray[indexPath.row]
        cell.textLabel?.text = "\(String(describing: city.addressDictionary!["Name"]!))"
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let city = self.locationViewModel.cityArray[indexPath.row]
        let cityString = "\(String(describing: city.addressDictionary!["Name"]!))"
        
        self.locationText.text = cityString
    }
}
