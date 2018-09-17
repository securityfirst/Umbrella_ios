//
//  DifficultyCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class DifficultyCell: UITableViewCell {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        headerView.roundCorners([.topLeft, .topRight], radius: 14)
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
    func configure(withViewModel viewModel:DifficultyViewModel, indexPath: IndexPath) {
        
        let difficulty = viewModel.difficulties[indexPath.row]
        self.titleLabel.text = difficulty.name
        
        if difficulty.name == "Beginner".localized() {
            self.descriptionLabel.text = "I want to know how to make a strong password".localized()
            self.headerView.backgroundColor = #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1)
            self.iconImageView.image = #imageLiteral(resourceName: "iconBeginner")
        } else if difficulty.name == "Advanced".localized() {
            self.descriptionLabel.text = "I always have too many passwords, help me manage them".localized()
            self.headerView.backgroundColor = #colorLiteral(red: 0.9661672711, green: 0.7777593136, blue: 0.215906769, alpha: 1)
            self.iconImageView.image = #imageLiteral(resourceName: "iconAdvanced")
        } else if difficulty.name == "Expert".localized() {
            self.descriptionLabel.text = "I need to know what to do in case people force me to hand over my passwords".localized()
            self.headerView.backgroundColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
            self.iconImageView.image = #imageLiteral(resourceName: "iconExpert")
        }
    }

}
