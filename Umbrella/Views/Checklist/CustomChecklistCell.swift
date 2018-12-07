//
//  CustomChecklistCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class CustomChecklistCell: UITableViewCell {
    
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
    func configure(withViewModel viewModel:CustomChecklistViewModel, indexPath: IndexPath) {
        let checklist = viewModel.customChecklists[indexPath.row]
        let checklistChecked = viewModel.customChecklistChecked.filter { $0.customChecklistId == checklist.id }
        
        if checklist.items.count == 0 {
            self.percentLabel.text = "0%"
        } else {
            let percent = String(format: "%.f%%", Float(checklistChecked.count) / (Float(checklist.items.count)) * 100)
            self.percentLabel.text = percent
        }
        
        self.titleLabel.text = checklist.name
    }
}
