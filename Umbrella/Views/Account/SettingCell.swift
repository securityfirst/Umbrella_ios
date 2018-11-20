//
//  SettingCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var optionSwitch: UISwitch!
    
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
        }
    }
    
    //
    // MARK: - Actions

    @IBAction func changeSwitchAction(_ sender: UISwitch) {
        
        if sender.tag == 0 {
            UserDefaults.standard.set(sender.isOn, forKey: "skipPassword")
        } else if sender.tag == 2 {
            UserDefaults.standard.set(sender.isOn, forKey: "showUpdateAsNotification")
        }
        
        UserDefaults.standard.synchronize()
    }
    
}
