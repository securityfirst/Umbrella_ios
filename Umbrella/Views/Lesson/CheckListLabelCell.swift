//
//  CheckListLabelCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class CheckListLabelCell: UITableViewCell {

    //
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    
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
    func configure(withViewModel viewModel:LessonCheckListViewModel, indexPath: IndexPath) {
        
        if let checkList = viewModel.checklist {
            let item = checkList.items[indexPath.row]
            
            self.titleLabel.text = item.name
        }
    }

}
