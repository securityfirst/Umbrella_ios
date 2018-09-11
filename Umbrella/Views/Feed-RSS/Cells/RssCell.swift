//
//  RssCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 29/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class RssCell: UITableViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
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
    func configure(withViewModel viewModel:RssViewModel, indexPath: IndexPath) {
        
        let item = viewModel.rssArray[indexPath.row]
        self.titleLabel.text = item.rssFeed?.title
        self.descriptionLabel.text = item.rssFeed?.description
    }

}
