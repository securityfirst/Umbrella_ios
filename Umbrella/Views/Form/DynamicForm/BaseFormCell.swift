//
//  BaseFormCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class BaseFormCell: UITableViewCell {
    
    //
    // MARK: - Properties
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //
    // MARK: - Functions
    
    /// Save form
    func saveForm() {
        fatalError("method \"save\" has not been implemented")
    }
}
