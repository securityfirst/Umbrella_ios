//
//  SettingLocationViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 22/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import CoreLocation

class SettingLocationViewController: UIViewController {
    
    //
    // MARK: - Properties
    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var cityTableView: UITableView!
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Save place
    ///
    /// - Parameter country: Country
    fileprivate func savePlace(_ country: Country) {
        NotificationCenter.default.post(name: Notification.Name("UpdateLocation"), object: nil, userInfo: ["location": (city: country.name, country: country.name, countryCode: country.codeAlpha2)])
        UserDefaults.standard.set(country.name, forKey: "LocationCity")
        UserDefaults.standard.set(country.name, forKey: "LocationCountry")
        UserDefaults.standard.set(country.codeAlpha2, forKey: "LocationCountryCode")
        NotificationCenter.default.post(name: Notification.Name("ContinueWizard"), object: nil)
    }
    
    //
    // MARK: - Actions
    
    @IBAction func saveAction(_ sender: Any) {
        if self.locationViewModel.cityArray.count > 0 {
            if let country = self.locationViewModel.cityArray.first {
                savePlace(country)
            }
        }
    }
}

//
// MARK: - UITextFieldDelegate
extension SettingLocationViewController: UITextFieldDelegate {
    
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
            
            self.locationViewModel.searchCountry(name: updatedText)
            self.cityTableView.reloadData()
        }
        
        return true
    }
}

// MARK: - UITableViewDataSource
extension SettingLocationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locationViewModel.cityArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SettingItemCell = (tableView.dequeueReusableCell(withIdentifier: "SettingItemCell", for: indexPath) as? SettingItemCell)!
        
        let country = self.locationViewModel.cityArray[indexPath.row]
        cell.titleLabel.text = country.name
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingLocationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        for cell in tableView.visibleCells {
            let settingCell: SettingItemCell = (cell as? SettingItemCell)!
            
            if tableView.cellForRow(at: indexPath) == cell {
                settingCell.checkImageView.image = #imageLiteral(resourceName: "checkSelected")
            } else {
                settingCell.checkImageView.image = #imageLiteral(resourceName: "groupNormal")
            }
        }
        
        let country = self.locationViewModel.cityArray[indexPath.row]
        self.locationText.text = country.name
        savePlace(country)
    }
}
