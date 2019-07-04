//
//  ChatRequestCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 01/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatRequestCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:ChatRequestViewModel, indexPath: IndexPath) {
        
        let item = viewModel.items[indexPath.row]
        self.nameLabel.text = item.name
        self.iconImageView.image = item.icon
        self.iconImageView.tintColor = #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1)
    }

}
