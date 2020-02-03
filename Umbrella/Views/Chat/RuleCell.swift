//
//  RuleCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 03/02/2020.
//  Copyright © 2020 Security First. All rights reserved.
//

import UIKit

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

    @IBAction func okAction(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "ruleFirstLogin")
        NotificationCenter.default.post(name: Notification.Name("SyncedMatrix"), object: nil)
    }
}
