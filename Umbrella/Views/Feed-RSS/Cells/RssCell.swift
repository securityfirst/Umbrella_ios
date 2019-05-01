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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:RssViewModel, indexPath: IndexPath) {
        
        if viewModel.rssArray.count == 0 {
            return
        }
        
        let item = viewModel.rssArray[indexPath.row]
        self.titleLabel.text = item.result.rssFeed?.title
        self.descriptionLabel.text = item.result.rssFeed?.description
        
        let language: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        // Arabic(ar) or Persian Iranian(fa)
        if language == "ar" || language == "fa" {
            self.titleLabel.textAlignment = .right
            self.descriptionLabel.textAlignment = .right
        } else {
            self.titleLabel.textAlignment = .left
            self.descriptionLabel.textAlignment = .left
        }
    }

}
