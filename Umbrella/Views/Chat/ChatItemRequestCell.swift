//
//  ChatItemRequestCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 01/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatItemRequestCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:ChatItemRequestViewModel, indexPath: IndexPath) {
        
        switch viewModel.item.type {
        case .forms:
            if viewModel.umbrella.loadFormAnswersByCurrentLanguage().count > 0 && indexPath.row <= viewModel.umbrella.loadFormAnswersByCurrentLanguage().count - 1 {
                let form = viewModel.umbrella.loadFormAnswersByCurrentLanguage()[indexPath.row]
                self.nameLabel.text = loadForm(formId: form.formId, forms: viewModel.umbrella.loadFormByCurrentLanguage()).name
            }
        case .checklists:
            
            if indexPath.section == 0 {
                let item = viewModel.favouriteChecklistChecked[indexPath.row]
                self.nameLabel.text = item.subCategoryName
            } else if indexPath.section == 1 {
                let item = viewModel.checklistChecked[indexPath.row]
                self.nameLabel.text = item.subCategoryName
            } else if indexPath.section == 2 {
                let item = viewModel.customChecklists[indexPath.row]
                self.nameLabel.text = item.name
            } else if indexPath.section == 3 {
                let item = viewModel.pathways[indexPath.row]
                self.nameLabel.text = item.name
            }
            
        case .answers: break
        case .file: break
        case .invite: break
            
        }
    }
    
    /// Get the form of the FormId
    ///
    /// - Parameters:
    ///   - formId: Int
    ///   - forms: [Form]
    /// - Returns: Form
    func loadForm(formId: Int, forms: [Form]) -> Form {
        
        for form in forms where form.id == formId {
            return form
        }
        
        return Form()
    }
}
