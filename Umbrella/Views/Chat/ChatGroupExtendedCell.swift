//
//  ChatGroupExtendedCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatGroupExtendedCell: UICollectionViewCell {
    
    @IBOutlet weak var ovalView: UIView!
    @IBOutlet weak var firstLetterLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:ChatClientViewModel, indexPath: IndexPath) {
        
        let item = viewModel.rooms[indexPath.row]
        self.firstLetterLabel.text = item.name.first?.uppercased()
        self.usernameLabel.text = item.name
        self.ovalView.backgroundColor = Lessons.colors[indexPath.row % Lessons.colors.count]
    }
}
