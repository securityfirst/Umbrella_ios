//
//  PathwayCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class PathwayCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:PathwayViewModel, indexPath: IndexPath) {
        
        let checklist = viewModel.category?.checkLists[indexPath.row]
        if let checklist = checklist {
            self.titleLabel.text = checklist.name
            
            if let iconImageView = self.iconImageView {
                iconImageView.image = checklist.favourite ? #imageLiteral(resourceName: "icStarSelected") : #imageLiteral(resourceName: "icStarBorder")
            }
        }
    }
}
