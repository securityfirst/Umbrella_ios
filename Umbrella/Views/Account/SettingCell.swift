//
//  SettingCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import UserNotifications

class SettingCell: UITableViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var optionWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var spaceTitleConstraint: NSLayoutConstraint!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:SettingsViewModel, indexPath: IndexPath) {
        
        if let tableSection = TableSection(rawValue: indexPath.section), let item = viewModel.items[tableSection]?[indexPath.row] {
            self.titleLabel.text = item.title
            self.subtitleLabel.text = item.subtitle
            self.accessoryType = item.hasAccessory ? .disclosureIndicator : .none
            optionSwitch.isHidden = !item.hasSwitch
            optionWidthConstraint.constant = !item.hasSwitch ? 0 : 49
            optionSwitch.tag = tableSection.rawValue
            
            // Skip password
            if tableSection.rawValue == 0 && item.hasSwitch {
                let showUpdateAsNotification = UserDefaults.standard.object(forKey: "skipPassword") as? Bool
                optionSwitch.isOn = showUpdateAsNotification ?? false
            }
            
            // Show update of the Feed as notification
            if tableSection.rawValue == 2 {
                let showUpdateAsNotification = UserDefaults.standard.object(forKey: "showUpdateAsNotification") as? Bool
                optionSwitch.isOn = showUpdateAsNotification ?? false
            }
            
            // Interval
            if tableSection.rawValue == 1 && indexPath.row == 0 {
                let interval = UserDefaults.standard.object(forKey: "Interval") as? String
                
                if interval != nil && interval != "" && interval != "-1" {
                    
                    let minOrHours = Int(interval!)! / 60
                    if minOrHours >= 1 {
                        self.subtitleLabel.text = "\(minOrHours) \("hour(s)".localized())"
                    } else {
                        self.subtitleLabel.text = "\(interval!) min"
                    }
                    
                } else {
                    self.subtitleLabel.text = "Manually".localized()
                }
            }
            
            self.iconWidthConstraint.constant = 0
            self.spaceTitleConstraint.constant = 0
            self.iconImageView.image = nil
            
            if self.titleLabel.text == "Select Language".localized() {
                self.iconWidthConstraint.constant = 20
                self.spaceTitleConstraint.constant = 5
                
                if self.subtitleLabel.text == "English".localized() {
                    self.iconImageView.image = #imageLiteral(resourceName: "GB")
                } else if self.subtitleLabel.text == "Spanish".localized() {
                    self.iconImageView.image = #imageLiteral(resourceName: "ES")
                } else if self.subtitleLabel.text == "Chinese".localized() {
                    self.iconImageView.image = #imageLiteral(resourceName: "CN")
                }
            }
            
            self.layoutIfNeeded()
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func changeSwitchAction(_ sender: UISwitch) {
        
        if sender.tag == 0 {
            UserDefaults.standard.set(sender.isOn, forKey: "skipPassword")
            
            if sender.isOn {
                var oldPassword = ""
                let passwordCustom: Bool = UserDefaults.standard.object(forKey: "passwordCustom") as? Bool ?? false
                if passwordCustom {
                    oldPassword = CustomPassword.shared.password
                } else {
                    oldPassword = Database.password
                }
                
                let sqlManager = SQLManager(databaseName: Database.name, password: oldPassword)
                
                sqlManager.changePassword(oldPassword: oldPassword, newPassword: Database.password)
                
                UserDefaults.standard.set(false, forKey: "passwordCustom")
                UserDefaults.standard.synchronize()
                CustomPassword.shared.password = ""
            }
            
        } else if sender.tag == 2 {
            
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (permissionGranted, error) in
                DispatchQueue.main.async {
                    if permissionGranted == false {
                        sender.isOn = false
                        UIAlertController.alert(title: "Alert".localized(), message: "You can enable access in Settings> Umbrela> Notifications", cancelButtonTitle: "OK".localized())
                        
                    } else {
                        UserDefaults.standard.set(sender.isOn, forKey: "showUpdateAsNotification")
                    }
                }
                print(error as Any)
            }
        }
        UserDefaults.standard.synchronize()
    }
}
