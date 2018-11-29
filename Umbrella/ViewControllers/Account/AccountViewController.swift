//
//  AccountViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Toast_Swift
import Localize_Swift

class AccountViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var accountViewModel: AccountViewModel = {
        let accountViewModel = AccountViewModel()
        return accountViewModel
    }()
    var askForPasswordView: AskForPasswordView!
    
    @IBOutlet weak var accountTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Account".localized()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    @objc func updateLanguage() {
        self.title = "Account".localized()
        self.accountViewModel.loadItems()
        self.accountTableView.reloadData()
    }
    
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
            UIApplication.shared.keyWindow!.makeToast(message, duration: 3.0, position: .top)
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
            
            self.askForPasswordView = (Bundle.main.loadNibNamed("AskForPasswordView", owner: self, options: nil)![0] as? AskForPasswordView)!
            self.askForPasswordView.show(view: self.view)
            
            self.askForPasswordView.save { (password, confirm) in
                print(password)
                print(confirm)
                
                if password.count > 0 && confirm.count > 0 &&
                    self.validatePassword(password: password, confirm: confirm) {
                    let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
                    
                    var oldPassword = ""
                    let passwordCustom: Bool = UserDefaults.standard.object(forKey: "passwordCustom") as? Bool ?? false
                    if passwordCustom {
                        oldPassword = CustomPassword.shared.password
                    } else {
                        oldPassword = Database.password
                    }
                    
                    sqlManager.changePassword(oldPassword: oldPassword, newPassword: password)
                    CustomPassword.shared.password = password
                    self.askForPasswordView.close()
                }
            }
            
            self.askForPasswordView.skip {
                let alertController = UIAlertController(title: "Skip setting password".localized(), message: "Are you sure you want to continue using the app without setting the password? \n\nThis significantly diminishes your safely in regards with any identifiable data you input into Umbrella.".localized(), preferredStyle: UIAlertController.Style.alert)
                let saveAction = UIAlertAction(title: "YES".localized(), style: UIAlertAction.Style.default, handler: { (action) in
                    UserDefaults.standard.set(true, forKey: "skipPassword")
                    UserDefaults.standard.synchronize()
                })
                
                let cancelAction = UIAlertAction(title: "NO".localized(), style: UIAlertAction.Style.cancel, handler: { (action) in
                    
                })
                
                alertController.addAction(saveAction)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
        case AccountItem.switchRepo:
            let app = (UIApplication.shared.delegate as? AppDelegate)!
            app.show()
            
        default:
            break
        }
    }
}
