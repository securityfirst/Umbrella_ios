//
//  RuleCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 03/02/2020.
//  Copyright © 2020 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class RuleCell: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.messageLabel.text = "Welcome to Umbrella Chat! Your profile is currently invisible to other users. If you want your friends and colleagues to be able find you, please join any public group.".localized()
    }

    @IBAction func okAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "ruleFirstLogin")
        NotificationCenter.default.post(name: Notification.Name("SyncedMatrix"), object: nil)
    }
}
