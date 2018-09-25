//
//  TextFieldCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class TextFieldCell: BaseFormCell {

    //
    // MARK: - Properties
    @IBOutlet weak var valueText: UITextField!
    weak var delegate: BaseFormCellDelegate?
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        valueText.setBottomBorder()
        valueText.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        valueText.placeholder = itemForm.label
        self.indexPath = indexPath
        valueText.accessibilityHint = valueText.placeholder
        
        //Load answers
        for formAnswer in viewModel.formAnswers where formAnswer.itemFormId == itemForm.id {
            valueText.text = formAnswer.text
        }
    }
    
    /// Save the data in database
    override func saveForm() {
        if (valueText.text?.count)! > 0 {
            self.delegate?.saveForm(cell: self, indexPath: self.indexPath)
        }
    }
}

//
// MARK: - UITextFieldDelegate
extension TextFieldCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        valueText.layer.shadowColor = #colorLiteral(red: 0.262745098, green: 0.6274509804, blue: 0.7921568627, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        valueText.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
}
