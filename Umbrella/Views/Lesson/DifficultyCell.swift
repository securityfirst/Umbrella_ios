//
//  DifficultyCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class DifficultyCell: UITableViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Bugfix - In iPhone 5/5s, for some reason the direct side constraint doesn't work and the view ends up getting larger than the superview and does not show the cornerRadius correctly, so I made that modification of the frame to solve the problem.
        var frame = headerView.frame
        frame.size.width = self.bounds.size.width - 30
        headerView.frame = frame
        
        headerView.roundCorners([.topRight, .topLeft], radius: 14)
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
            self.headerView.backgroundColor = Lessons.colors[0]
        } else if difficulty.name == "Advanced".localized() {
            self.iconImageView.image = #imageLiteral(resourceName: "iconAdvanced")
            self.headerView.backgroundColor = Lessons.colors[1]
        } else if difficulty.name == "Expert".localized() {
            self.iconImageView.image = #imageLiteral(resourceName: "iconExpert")
            self.headerView.backgroundColor = Lessons.colors[2]
        }
    }
    
}
