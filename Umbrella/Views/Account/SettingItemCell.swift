//
//  SettingItemCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 20/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class SettingItemCell: UITableViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconConstraint: NSLayoutConstraint!
    
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
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:SettingCellProtocol, indexPath: IndexPath) {
        
        let item = viewModel.items[indexPath.row]
        self.titleLabel.text = item.name
        self.checkImageView.image = item.checked ? #imageLiteral(resourceName: "checkSelected") : #imageLiteral(resourceName: "groupNormal")
    }
}
