//
//  FormCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

protocol FormCellDelegate: class {
    func removeAction(indexPath: IndexPath)
    func editAction(indexPath: IndexPath)
    func shareAction(indexPath: IndexPath)
}

class FormCell: UITableViewCell {

    //
    // MARK: - Properties
    @IBOutlet weak var formBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editHeightConstraint: NSLayoutConstraint!
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: FormCellDelegate?
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
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
    func configure(withViewModel viewModel:FormViewModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.editHeightConstraint.constant = 0
        
        if viewModel.umbrella.formAnswers.count > 0 && indexPath.row <= viewModel.umbrella.formAnswers.count - 1 {
            if indexPath.section == 0 {
                let form = viewModel.umbrella.formAnswers[indexPath.row]
                titleLabel.text = loadForm(formId: form.formId, forms: viewModel.umbrella.forms).name
                self.editHeightConstraint.constant = 30
            } else if indexPath.section == 1 {
                let form = viewModel.umbrella.forms[indexPath.row]
                titleLabel.text = form.name
            }
        } else if viewModel.umbrella.forms.count > 0 && indexPath.row <= viewModel.umbrella.forms.count - 1 {
            let form = viewModel.umbrella.forms[indexPath.row]
            titleLabel.text = form.name
        }
        
        self.layoutIfNeeded()
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
    
    //
    // MARK: - Actions
    
    @IBAction func removeAction(_ sender: Any) {
        self.delegate?.removeAction(indexPath: self.indexPath)
    }
    
    @IBAction func editAction(_ sender: Any) {
        self.delegate?.editAction(indexPath: self.indexPath)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        self.delegate?.shareAction(indexPath: self.indexPath)
    }
}
