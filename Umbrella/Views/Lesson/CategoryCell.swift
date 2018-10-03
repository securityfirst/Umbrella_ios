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
        
        let headerItem = viewModel.getCategories(ofLanguage: Locale.current.languageCode!)[indexPath.section - 1]
        
        let category = headerItem.categories[indexPath.row]
        self.nameLabel.text = category.name
    }
}
