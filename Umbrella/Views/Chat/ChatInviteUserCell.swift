//
//  ChatInviteUserCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatInviteUserCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:ChatInviteUserViewModel, indexPath: IndexPath) {
        
        if viewModel.usersArray.indexExists(indexPath.row) {
            let item = viewModel.usersArray[indexPath.row]
            self.usernameLabel.text = item.displayName
        }
    }

}
