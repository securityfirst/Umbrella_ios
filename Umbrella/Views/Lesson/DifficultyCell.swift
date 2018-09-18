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
        
        self.headerView.backgroundColor = Lessons.colors[indexPath.row % Lessons.colors.count]
        self.descriptionLabel.text = difficulty.description
        
        if difficulty.name == "Beginner".localized() {
            self.iconImageView.image = #imageLiteral(resourceName: "iconBeginner")
        } else if difficulty.name == "Advanced".localized() {
            self.iconImageView.image = #imageLiteral(resourceName: "iconAdvanced")
        } else if difficulty.name == "Expert".localized() {
            self.iconImageView.image = #imageLiteral(resourceName: "iconExpert")
        }
    }
    
}
