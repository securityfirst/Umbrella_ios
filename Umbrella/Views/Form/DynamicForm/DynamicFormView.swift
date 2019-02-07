//
//  DynamicFormView.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class DynamicFormView: UIView {
    
    //
    // MARK: - Properties
    lazy var dynamicFormViewModel: DynamicFormViewModel = {
        let dynamicFormViewModel = DynamicFormViewModel()
        return dynamicFormViewModel
    }()
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var dynamicTableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
    }
    
    //
    // MARK: - Functions
    
    /// Attribute the title to the view
    ///
    /// - Parameter title: String
    func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    /// Keyboard notification when change the frame
    ///
    /// - Parameter notification: NSNotification
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.bottomConstraint?.constant = 0.0
            } else {
                // Number 50 is to navigation view (Back - Next)
                self.bottomConstraint?.constant = (endFrame?.size.height)! - 48 - 50
            }
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: animationCurve,
                           animations: { self.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    /// Hidden the keyboard
    func keyboardWillBeHidden() {
        self.endEditing(true)
    }
    
    /// Save the data in forms
    func saveForm() {
        for cellTableView in cellsForTableView() {
            let cell = (cellTableView as? BaseFormCell)!
            cell.saveForm()
        }
    }
    
    /// This function return whole cell for tableView
    ///
    /// - Returns: Cells
    func cellsForTableView() -> [UITableViewCell] {
        let sections = self.dynamicTableView.numberOfSections
        var cells: Array = [UITableViewCell]()
        
        for section in 0..<sections {
            let rows = self.dynamicTableView.numberOfRows(inSection: section)
            
            for row in 0..<rows {
                let indexPath = IndexPath(row: row, section: section)
                let cellForm = self.dynamicTableView.cellForRow(at: indexPath)
                if let cell = cellForm {
                    cells.append(cell)
                }
            }
        }
        return cells
    }
    
    /// Save a textField
    ///
    /// - Parameters:
    ///   - cell: BaseFormCell
    ///   - formAnswerId: Int64
    ///   - formId: Int
    ///   - itemForm: ItemForm
    fileprivate func saveTextField(_ cell: BaseFormCell, _ formAnswerId: Int64, _ formId: Int, _ itemForm: ItemForm) {
        let formCell = (cell as? TextFieldCell)!
        
        let formAnswer = FormAnswer(formAnswerId: Int(formAnswerId), formId: formId, itemFormId: itemForm.id, optionItemId: -1, text: formCell.valueText.text!, choice: -1)
        
        for answer in dynamicFormViewModel.formAnswers where (answer.itemFormId == itemForm.id && answer.formId == formId) {
            formAnswer.id = answer.id
        }
        _ = dynamicFormViewModel.save(formAnswer: formAnswer)
    }
    
    /// Save a textArea
    ///
    /// - Parameters:
    ///   - cell: BaseFormCell
    ///   - formAnswerId: Int64
    ///   - formId: Int
    ///   - itemForm: ItemForm
    fileprivate func saveTextArea(_ cell: BaseFormCell, _ formAnswerId: Int64, _ formId: Int, _ itemForm: ItemForm) {
        let formCell = (cell as? TextAreaCell)!
        
        let formAnswer = FormAnswer(formAnswerId: Int(formAnswerId), formId: formId, itemFormId: itemForm.id, optionItemId: -1, text: formCell.textView.text!, choice: -1)
        
        for answer in dynamicFormViewModel.formAnswers where (answer.itemFormId == itemForm.id && answer.formId == formId) {
            formAnswer.id = answer.id
        }
        _ = dynamicFormViewModel.save(formAnswer: formAnswer)
    }
    
    /// Save a list of multichoice
    ///
    /// - Parameters:
    ///   - cell: BaseFormCell
    ///   - formAnswerId: Int64
    ///   - formId: Int
    ///   - itemForm: ItemForm
    fileprivate func saveMultiChoice(_ cell: BaseFormCell, _ formAnswerId: Int64, _ formId: Int, _ itemForm: ItemForm) {
        let formCell = (cell as? MultiChoiceCell)!
        
        for view in formCell.subviews where view is ChoiceButton {
            let button = (view as? ChoiceButton)!
            
            let formAnswer = FormAnswer(formAnswerId: Int(formAnswerId), formId: formId, itemFormId: itemForm.id, optionItemId: button.index, text: "", choice: button.index)
            
            for answer in dynamicFormViewModel.formAnswers where (answer.formId == formId && answer.itemFormId == itemForm.id && answer.optionItemId == button.index) {
                formAnswer.id = answer.id
            }
            
            if button.state {
                _ = dynamicFormViewModel.save(formAnswer: formAnswer)
            } else {
                //Remove
                _ = dynamicFormViewModel.remove(formAnswer: formAnswer)
            }
        }
    }
    
    //
    // MARK: - UIResponder
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.keyboardWillBeHidden()
    }
    
}

//
// MARK: - BaseFormCellDelegate
extension DynamicFormView: BaseFormCellDelegate {
    
    /// Save the form
    ///
    /// - Parameters:
    ///   - cell: BaseFormCell
    ///   - indexPath: IndexPath
    func saveForm(cell: BaseFormCell, indexPath: IndexPath) {
        let formId = dynamicFormViewModel.screen.formId
        let itemForm = dynamicFormViewModel.screen.items[indexPath.row]
        let formAnswerId = dynamicFormViewModel.newFormAnswerId == -1 ? dynamicFormViewModel.formAnswerId : dynamicFormViewModel.newFormAnswerId
        
        if cell is TextFieldCell {
            saveTextField(cell, formAnswerId, formId, itemForm)
        } else if cell is TextAreaCell {
            saveTextArea(cell, formAnswerId, formId, itemForm)
        } else if cell is MultiChoiceCell {
            saveMultiChoice(cell, formAnswerId, formId, itemForm)
        } else if cell is SingleChoiceCell {
            saveMultiChoice(cell, formAnswerId, formId, itemForm)
        }
    }
}

//
// MARK: - UITableViewDataSource
extension DynamicFormView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dynamicFormViewModel.screen.items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if dynamicFormViewModel.screen.items[indexPath.row].formType == .multiChoice {
            return CGFloat(dynamicFormViewModel.screen.items[indexPath.row].options.count * 30)
        }
        
        return dynamicFormViewModel.screen.items[indexPath.row].formType.values().sizeOfCell
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = dynamicFormViewModel.screen.items[indexPath.row].formType.values().identifierCell
        let cell: UITableViewCell
        
        switch dynamicFormViewModel.screen.items[indexPath.row].formType {
        case .textInput:
            let cellCustom: TextFieldCell = (tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TextFieldCell)!
            cellCustom.configure(withViewModel: dynamicFormViewModel, indexPath: indexPath)
            cellCustom.delegate = self
            cell = cellCustom
        case .textArea:
            let cellCustom: TextAreaCell = (tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TextAreaCell)!
            cellCustom.configure(withViewModel: dynamicFormViewModel, indexPath: indexPath)
            cellCustom.delegate = self
            cellCustom.delegateForm = self
            cell = cellCustom
        case .multiChoice:
            let cellCustom: MultiChoiceCell = (tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MultiChoiceCell)!
            cellCustom.configure(withViewModel: dynamicFormViewModel, indexPath: indexPath)
            cellCustom.delegate = self
            cell = cellCustom
        case .singleChoice:
            let cellCustom: SingleChoiceCell = (tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? SingleChoiceCell)!
            cellCustom.configure(withViewModel: dynamicFormViewModel, indexPath: indexPath)
            cellCustom.delegate = self
            cell = cellCustom
        case .label:
            let cellCustom: LabelCell = (tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? LabelCell)!
            cellCustom.configure(withViewModel: dynamicFormViewModel, indexPath: indexPath)
            cell = cellCustom
        case .none:
            cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
        
        return cell
    }
}

//
// MARK: - UITableViewDelegate
extension DynamicFormView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.keyboardWillBeHidden()
    }
}

//
// MARK: - TextAreaCellDelegate
extension DynamicFormView: TextAreaCellDelegate {
    
    func textAreaCell(cell: TextAreaCell, indexPath: IndexPath) {
        self.dynamicTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}
