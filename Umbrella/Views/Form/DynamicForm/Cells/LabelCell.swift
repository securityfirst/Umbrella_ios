//
//  LabelCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 25/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class LabelCell: BaseFormCell {

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
    
    /// Configure the cell with data by ViewModel
    ///
    /// - Parameters:
    ///   - viewModel: viewModel
    ///   - indexPath: indexPath
    func configure(withViewModel viewModel:DynamicFormViewModel, indexPath: IndexPath) {
        let itemForm = viewModel.screen.items[indexPath.row]
        self.titleLabel.text = itemForm.label
    }
    
    /// Save the data in database
    override func saveForm() {
        // This cell doesn't save nothing. It is not necessary to implement.
    }
}
