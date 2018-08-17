//
//  TextAreaCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

protocol TextAreaCellDelegate: class {
    func textAreaCell(cell: TextAreaCell, indexPath: IndexPath)
}

class TextAreaCell: BaseFormCell {

    //
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    var placeholderLabel : UILabel!
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: TextAreaCellDelegate?
    weak var delegateForm: BaseFormCellDelegate?
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        textView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty
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
        self.indexPath = indexPath
        let itemForm = viewModel.screen.items[indexPath.row]
        titleLabel.text = itemForm.label
        placeholderLabel.accessibilityHint = titleLabel.text
        
        if itemForm.hint.count > 0 {
            placeholderLabel.text = itemForm.hint
            placeholderLabel.accessibilityHint = itemForm.hint
            placeholderLabel.sizeToFit()
        }
        
        //Load answers
        for formAnswer in viewModel.formAnswers where formAnswer.itemFormId == itemForm.id {
            textView.text = formAnswer.text
            placeholderLabel.isHidden = true
            
        }
    }

    /// Save the data in database
    override func saveForm() {
        if (textView.text?.count)! > 0 {
            self.delegateForm?.saveForm(cell: self, indexPath: self.indexPath)
        }
    }
}

//
// MARK: - UITextViewDelegate
extension TextAreaCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.delegate?.textAreaCell(cell: self, indexPath: self.indexPath)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
