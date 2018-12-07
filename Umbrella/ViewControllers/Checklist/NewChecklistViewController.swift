//
//  NewChecklistViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class NewChecklistViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var newChecklistViewModel: NewChecklistViewModel = {
        let newChecklistViewModel = NewChecklistViewModel()
        return newChecklistViewModel
    }()
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var newCheckItemTableView: UITableView!
    var editIndexPath: IndexPath = IndexPath(row: -1, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = newChecklistViewModel.name
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
        self.newChecklistViewModel.updateChecklistCheckedOfCustomChecklist(customChecklistId: newChecklistViewModel.customChecklist.id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.saveChecklist()
        }
    }
    
    //
    // MARK: - Functions
    
    func saveChecklist() {
        self.newChecklistViewModel.customChecklist.items.forEach { customCheckItem in
            
            if customCheckItem.name == "Title".localized() {
                return
            }
            
            let rowId = self.newChecklistViewModel.insertCustomCheckItem(customCheckItem)
            let newItem = (customCheckItem.id == -1)
            customCheckItem.id = rowId
            
            if newItem {
                if customCheckItem.checked {
                    self.newChecklistViewModel.insertCustomCheckChecked(customCheckItem)
                } else {
                    self.newChecklistViewModel.removeCustomCheckChecked(customCheckItem)
                }
            }
        }
    }
    
    @objc func updateLanguage() {
        self.newCheckItemTableView?.reloadData()
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
                UIView.animate(withDuration: duration,
                               delay: 0,
                               options: animationCurve,
                               animations: { self.view.layoutIfNeeded() },
                               completion: nil)
            } else {
                self.bottomConstraint?.constant = (endFrame?.size.height)! - 48
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension NewChecklistViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newChecklistViewModel.customChecklist.items.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.newChecklistViewModel.customChecklist.items.count {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
            
            return cell
        } else {
            let cell: NewCheckItemCell = (tableView.dequeueReusableCell(withIdentifier: "NewCheckItemCell", for: indexPath) as? NewCheckItemCell)!
            
            cell.configure(withViewModel: self.newChecklistViewModel, indexPath: indexPath)
            cell.delegate = self
            cell.modeEdit(enable: (self.editIndexPath.row == indexPath.row))
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete".localized()
    }
}

// MARK: - UITableViewDelegate
extension NewChecklistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == self.newChecklistViewModel.customChecklist.items.count {
            return 64.0
        } else {
            return 80.0
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return (indexPath.row != self.newChecklistViewModel.customChecklist.items.count)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let customCheckItem = self.newChecklistViewModel.customChecklist.items[indexPath.row]
            self.newChecklistViewModel.customChecklist.items.remove(at: indexPath.row)
            self.newChecklistViewModel.removeCustomCheckItem(customCheckItem)
            self.newCheckItemTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == self.newChecklistViewModel.customChecklist.items.count {
            let customCheckItem = CustomCheckItem(name: "Title".localized(), checklistId: self.newChecklistViewModel.customChecklist.id)
            self.newChecklistViewModel.customChecklist.items.append(customCheckItem)
            self.editIndexPath = IndexPath(row: -1, section: 0)
            self.view.endEditing(true)
            tableView.reloadData()
        }
    }
}

// MARK: - NewCheckItemDelegate
extension NewChecklistViewController: NewCheckItemDelegate {
    
    func checkAction(indexPath: IndexPath) {
        let item = self.newChecklistViewModel.customChecklist.items[indexPath.row]
        item.checked = !item.checked
        
        if item.id != -1 {
            if item.checked {
                self.newChecklistViewModel.insertCustomCheckChecked(item)
            } else {
                self.newChecklistViewModel.removeCustomCheckChecked(item)
            }
        }
        self.newChecklistViewModel.updateChecklistCheckedOfCustomChecklist(customChecklistId: newChecklistViewModel.customChecklist.id)
        self.newCheckItemTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func editTextAction(indexPath: IndexPath, cell: NewCheckItemCell) {
        if self.editIndexPath.row != indexPath.row {
            cell.modeEdit(enable: true)
            cell.editText.delegate = self
            if cell.titleLabel.text != "Title".localized() {
                cell.editText.text = cell.titleLabel.text
            }
            cell.editText.becomeFirstResponder()
            
            let oldIndePath = IndexPath(row: self.editIndexPath.row, section: self.editIndexPath.section)
            self.editIndexPath = indexPath
            self.newCheckItemTableView.reloadRows(at: [oldIndePath], with: UITableView.RowAnimation.automatic)
        }
    }
}

//
// MARK: - UITextFieldDelegate
extension NewChecklistViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let item = self.newChecklistViewModel.customChecklist.items[self.editIndexPath.row]
        let cell: NewCheckItemCell = (self.newCheckItemTableView.cellForRow(at: self.editIndexPath) as? NewCheckItemCell)!
        cell.modeEdit(enable: false)
        if cell.editText.text!.count > 0 {
            cell.titleLabel.text = cell.editText.text
            item.name = cell.titleLabel.text!
        }
        
        self.editIndexPath = IndexPath(row: -1, section: 0)
        
        if item.id != -1 {
            let rowId = self.newChecklistViewModel.insertCustomCheckItem(item)
            item.id = Int(rowId)
        }
        
        self.view.endEditing(true)
        return true
    }
}
