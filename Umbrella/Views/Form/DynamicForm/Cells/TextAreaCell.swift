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
        
        self.textView.delegate = self
        self.placeholderLabel = UILabel()
        self.placeholderLabel.font = UIFont.italicSystemFont(ofSize: (self.textView.font?.pointSize)!)
        self.textView.addSubview(self.placeholderLabel)
        self.placeholderLabel.frame.origin = CGPoint(x: 5, y: (self.textView.font?.pointSize)! / 2)
        self.placeholderLabel.textColor = UIColor.lightGray
        self.placeholderLabel.isHidden = !self.textView.text.isEmpty
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
        self.titleLabel.text = itemForm.label
        self.placeholderLabel.accessibilityHint = self.titleLabel.text
        
        if itemForm.hint.count > 0 {
            self.placeholderLabel.text = itemForm.hint
            self.placeholderLabel.accessibilityHint = itemForm.hint
            self.placeholderLabel.sizeToFit()
        }
        
        //Load answers
        for formAnswer in viewModel.formAnswers where formAnswer.itemFormId == itemForm.id {
            self.textView.text = formAnswer.text
            self.placeholderLabel.isHidden = true
            
        }
    }

    /// Save the data in database
    override func saveForm() {
        if (self.textView.text?.count)! > 0 {
            self.delegateForm?.saveForm(cell: self, indexPath: self.indexPath)
        }
    }
}

//
// MARK: - UITextViewDelegate
extension TextAreaCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.placeholderLabel.isHidden = !textView.text.isEmpty
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
