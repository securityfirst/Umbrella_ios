//
//  CategoryCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 13/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

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
    }

    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:LessonViewModel, indexPath: IndexPath) {
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        
        let headerItem = viewModel.getCategories(ofLanguage: languageName)[indexPath.section - 1]
        
        let category = headerItem.categories[indexPath.row]
        if let nameLabel = self.nameLabel {
            nameLabel.text = category.name
        }
    }
}
