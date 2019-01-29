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
    var placeHolderLabel: UILabel!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.valueText.setBottomBorder()
        self.valueText.delegate = self
        self.placeHolderLabel = UILabel(frame: valueText.bounds)
        self.placeHolderLabel.numberOfLines = 0
        self.placeHolderLabel.font = UIFont(name: "Helvetica", size: 14)
        self.placeHolderLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.placeHolderLabel.lineBreakMode = .byWordWrapping
        self.valueText.addSubview(placeHolderLabel)
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.placeHolderLabel.frame = self.valueText.bounds
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
//        valueText.placeholder = itemForm.label
        self.placeHolderLabel.text = itemForm.label
        self.indexPath = indexPath
        self.valueText.accessibilityHint = itemForm.label
        
        //Load answers
        for formAnswer in viewModel.formAnswers where formAnswer.itemFormId == itemForm.id {
            self.valueText.text = formAnswer.text
            self.placeHolderLabel.isHidden = (formAnswer.text.count != 0)
        }
        
        self.valueText.layoutIfNeeded()
    }
    
    /// Save the data in database
    override func saveForm() {
        if (self.valueText.text?.count)! > 0 {
            self.delegate?.saveForm(cell: self, indexPath: self.indexPath)
        }
    }
}

//
// MARK: - UITextFieldDelegate
extension TextFieldCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.valueText.layer.shadowColor = #colorLiteral(red: 0.262745098, green: 0.6274509804, blue: 0.7921568627, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.valueText.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            self.placeHolderLabel.isHidden = (updatedText.count != 0)
        }
        
        return true
    }
}
