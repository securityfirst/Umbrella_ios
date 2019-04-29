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
    var editBeforeAddedNewItemIndexPath: IndexPath = IndexPath(row: -1, section: 0)
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = newChecklistViewModel.name
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
        if newChecklistViewModel.customChecklist != nil {
            self.newChecklistViewModel.updateChecklistCheckedOfCustomChecklist(customChecklistId: newChecklistViewModel.customChecklist.id)
        }
        
        let shareBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.shareAction(_:)))
        self.navigationItem.rightBarButtonItem = shareBarButton
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.saveChecklist()
        }
    }
    
    //
    // MARK: - Functions
    
    /// Save checklist
    func saveChecklist() {
        self.newChecklistViewModel.customChecklist.items.forEach { customCheckItem in
            
            if customCheckItem.name == "Item".localized() {
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
    
    /// Update Language
    @objc func updateLanguage() {
        self.navigationController?.popToRootViewController(animated: false)
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
    
    //
    // MARK: - Actions
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        var objectsToShare:[Any] = [Any]()
        
        var content: String = ""
        
        content += """
        <html>
        <head>
        <meta charset="UTF-8"> \n
        """
        content += "<title>\(self.newChecklistViewModel.customChecklist.name ?? "")</title> \n"
        content += "</head> \n"
        content += "<body style=\"display:block;width:100%;\"> \n"
        content += "<h1>Checklist</h1> \n"
        
        for checkItem in self.newChecklistViewModel.customChecklist.items {
            content += "<label><input type=\"checkbox\"\(checkItem.checked ? "checked" : "") readonly onclick=\"return false;\">\(checkItem.name)</label><br> \n"
        }
        
        content += """
        </form>
        </body>
        </html>
        """
        
        UIAlertController.alertSheet(title: "Alert".localized(), message: "Choose the format.".localized(), buttons: ["HTML", "PDF"], dismiss: { (option) in

            if option == 0 {
                // HTML
                let html = HTML(nameFile: "Checklist.html", content: content)
                let export = Export(html)
                let url = export.makeExport()
                objectsToShare = [url]
            } else if option == 1 {
                //PDF
                let pdf = PDF(nameFile: "Checklist.pdf", content: content)
                let export = Export(pdf)
                let url = export.makeExport()
                objectsToShare = [url]
            }
            
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.copyToPasteboard]
            
            activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed {
                    // User canceled
                    return
                }
            }
            
            self.present(activityVC, animated: true, completion: nil)
        }, cancel: {
            print("cancel")
        })
    }
}

// MARK: - UITableViewDataSource
extension NewChecklistViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.newChecklistViewModel.customChecklist == nil {
            return 0
        }
        
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            let customCheckItem = self.newChecklistViewModel.customChecklist.items[indexPath.row]
            self.newChecklistViewModel.customChecklist.items.remove(at: indexPath.row)
            self.newChecklistViewModel.removeCustomCheckItem(customCheckItem)
            self.newCheckItemTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
        
        return [delete]
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
            let customCheckItem = CustomCheckItem(name: "Item".localized(), checklistId: self.newChecklistViewModel.customChecklist.id)
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
        let cell: NewCheckItemCell = (self.newCheckItemTableView.cellForRow(at: indexPath) as? NewCheckItemCell)!
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

        if cell.editText.isHidden {
            self.newCheckItemTableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        } else {
            cell.checkImageView.image = item.checked ? #imageLiteral(resourceName: "checkSelected") : #imageLiteral(resourceName: "groupNormal")
        }
    }
    
    func editTextAction(indexPath: IndexPath, cell: NewCheckItemCell) {
        if self.editIndexPath.row != indexPath.row {
            cell.modeEdit(enable: true)
            cell.editText.delegate = self
            if cell.titleLabel.text != "Item".localized() {
                cell.editText.text = cell.titleLabel.text
            }
            cell.editText.becomeFirstResponder()
            
            let oldIndePath = IndexPath(row: self.editIndexPath.row, section: self.editIndexPath.section)
            self.editIndexPath = indexPath
            self.editBeforeAddedNewItemIndexPath = indexPath
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let item = self.newChecklistViewModel.customChecklist.items[self.editBeforeAddedNewItemIndexPath.row]
        let cell: NewCheckItemCell = (self.newCheckItemTableView.cellForRow(at: self.editBeforeAddedNewItemIndexPath) as? NewCheckItemCell)!
        cell.modeEdit(enable: false)
        if cell.editText.text!.count > 0 {
            cell.titleLabel.text = cell.editText.text
            item.name = cell.titleLabel.text!
        }
        
        self.editBeforeAddedNewItemIndexPath = IndexPath(row: -1, section: 0)
        
        if item.id != -1 {
            let rowId = self.newChecklistViewModel.insertCustomCheckItem(item)
            item.id = Int(rowId)
        }
    }
}
