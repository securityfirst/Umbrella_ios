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
                if indexPath.section == 0 {
                    let form = viewModel.umbrella.loadFormByCurrentLanguage()[indexPath.row]
                    self.nameLabel.text = form.name
                } else if indexPath.section == 1 {
                    let form = viewModel.umbrella.loadFormAnswersByCurrentLanguage()[indexPath.row]
                    self.nameLabel.text = loadForm(formId: form.formId, forms: viewModel.umbrella.loadFormByCurrentLanguage()).name
                }
            } else if viewModel.umbrella.loadFormByCurrentLanguage().count > 0 && indexPath.row <= viewModel.umbrella.loadFormByCurrentLanguage().count - 1 {
                let form = viewModel.umbrella.loadFormByCurrentLanguage()[indexPath.row]
                self.nameLabel.text = form.name
            }
        case .checklists: 
            let item = viewModel.checklists[indexPath.row]
            self.nameLabel.text = item.name
        case .answers: break
        case .file: break
            
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
