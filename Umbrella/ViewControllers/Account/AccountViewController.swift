//
//  AccountViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Toast_Swift

class AccountViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var accountViewModel: AccountViewModel = {
        let accountViewModel = AccountViewModel()
        return accountViewModel
    }()
    
    @IBOutlet weak var accountTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Account".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Validate if there is an url valid
    ///
    /// - Parameter urlString: String
    /// - Returns: Bool
    func validatePassword(password: String, confirm: String) -> Bool {
        
        var check = true
        var message = ""
        
        if !password.contains(confirm) {
            check = false
            message = "Passwords do not match.".localized()
        } else if password.count < 8 {
            check = false
            message = "Password too short.".localized()
        } else if !NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: password) || !NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: confirm) {
            check = false
            message = "Password must have at least one digit.".localized()
        } else if !NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: password) || !NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: confirm) {
            check = false
            message = "Password must have at least one capital letter.".localized()
        }
        
        if !check {
            self.view.makeToast(message, duration: 3.0, position: .bottom)
        }
        
        return check
    }
}

// MARK: - UITableViewDataSource
extension AccountViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accountViewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AccountCell = (tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as? AccountCell)!
        
        cell.configure(withViewModel: self.accountViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AccountViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.accountViewModel.items[indexPath.row]
        
        switch item.type {
            
        case AccountItem.settings:
            self.performSegue(withIdentifier: "settingsSegue", sender: nil)
        case AccountItem.mask: break
        case AccountItem.setPassword:
            let alertController = UIAlertController(title: "Set your password".localized(), message: "Your password must be at least 8 characters long and must contain at least one digit and one capital letter.", preferredStyle: UIAlertController.Style.alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Password".localized()
                textField.keyboardType = UIKeyboardType.alphabet
                textField.isSecureTextEntry = true
            }
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Confirm".localized()
                textField.keyboardType = UIKeyboardType.alphabet
                textField.isSecureTextEntry = true
            }
            let saveAction = UIAlertAction(title: "OK".localized(), style: UIAlertAction.Style.destructive, handler: { (action) in
                let passwordTextField = alertController.textFields![0] as UITextField
                let confirmTextField = alertController.textFields![1] as UITextField
                
                if let passwordCount = passwordTextField.text?.count, passwordCount > 0,
                    let confirmCount = confirmTextField.text?.count, confirmCount > 0,
                    self.validatePassword(password: passwordTextField.text!, confirm: confirmTextField.text!) {
                    let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
                    
                    var oldPassword = ""
                    if let passwordCustom: String = UserDefaults.standard.object(forKey: "passwordCustom") as? String {
                        oldPassword = passwordCustom
                    } else {
                        oldPassword = Database.password
                    }
                    
                    sqlManager.changePassword(oldPassword: oldPassword, newPassword: passwordTextField.text!)
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil)
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        case AccountItem.switchRepo:
            let app = (UIApplication.shared.delegate as? AppDelegate)!
            app.show()
            
        default:
            break
        }
    }
}
