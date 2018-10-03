//
//  ChecklistReviewCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class ChecklistReviewCell: UITableViewCell {

    //
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
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
    func configure(withViewModel viewModel:ChecklistViewModel, indexPath: IndexPath) {
        
            let checklistChecked = viewModel.checklistChecked[indexPath.row]
            self.titleLabel.text = checklistChecked.subCategoryName
            self.percentLabel.text = "\(checklistChecked.totalChecked / checklistChecked.totalItemsChecklist * 100)%"
    }
}
