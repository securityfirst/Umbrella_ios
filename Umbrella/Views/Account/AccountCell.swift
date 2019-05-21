//
//  AccountCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!

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
    func configure(withViewModel viewModel:AccountViewModel, indexPath: IndexPath) {
        
        let item = viewModel.items[indexPath.row]
        self.nameLabel.text = item.name
        
        let language: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        // Arabic(ar) or Persian Farsi(fa)
        if language == "ar" || language == "fa" {
            self.nameLabel.textAlignment = .right
        } else {
            self.nameLabel.textAlignment = .left
        }
    }
}
