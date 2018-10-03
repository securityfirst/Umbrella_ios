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
        
        var title = ""
        var percent = ""
        
        if indexPath.section == 0 {
            let checklistChecked = viewModel.itemTotalDone
            title = checklistChecked?.subCategoryName ?? ""
            if checklistChecked?.totalChecked ?? 0 == 0 {
                percent = "0%"
            } else {
                percent = String(format: "%.f%%", Float(checklistChecked?.totalChecked ?? 0) / (Float(checklistChecked?.totalItemsChecklist ?? 0)) * 100)
            }
        } else if indexPath.section == 1 {
            let checklistChecked = viewModel.favouriteChecklistChecked[indexPath.row]
            title = checklistChecked.subCategoryName
            percent = String(format: "%.f%%", Float(checklistChecked.totalChecked) / (Float(checklistChecked.totalItemsChecklist)) * 100)
        } else {
            let checklistChecked = viewModel.checklistChecked[indexPath.row]
            title = checklistChecked.subCategoryName
            percent = String(format: "%.f%%", Float(checklistChecked.totalChecked) / (Float(checklistChecked.totalItemsChecklist)) * 100)
        }
        
        self.titleLabel.text = title
        self.percentLabel.text = percent
    }
}
