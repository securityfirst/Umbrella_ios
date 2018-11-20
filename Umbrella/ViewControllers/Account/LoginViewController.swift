//
//  LoginViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 19/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginViewController: UIViewController {
    
    //
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordText.setBottomBorder()
        self.passwordText.delegate = self
        self.passwordText.becomeFirstResponder()
    }
    
    //
    // MARK: - Functions
    
    //
    // MARK: - Actions
    
    @IBAction func resetAction(_ sender: Any) {
        self.view.endEditing(true)
        let alertController = UIAlertController(title: "Confirm reset password".localized(), message: "Are you sure you want to reset your password?\nThis also means losing any data you might have entered so far.", preferredStyle: UIAlertController.Style.alert)
        let saveAction = UIAlertAction(title: "YES".localized(), style: UIAlertAction.Style.default, handler: { (action) in
            let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
            let umbrellaDatabase = UmbrellaDatabase(sqlProtocol: sqlManager)
            _ = umbrellaDatabase.dropTables()
            
            let gitHubDemo = (UserDefaults.standard.object(forKey: "gitHubDemo") as? String)!
            let gitManager = GitManager(url: URL(string: gitHubDemo)!, pathDirectory: .documentDirectory)
            
            do {
                try gitManager.deleteCloneInFolder(pathDirectory: .documentDirectory)
                UserDefaults.standard.set(false, forKey: "passwordCustom")
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: Notification.Name("ResetDemo"), object: nil)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
                UIApplication.shared.keyWindow?.addSubview(controller.view)
                controller.loadTent {
                    self.dismiss(animated: true, completion: nil)
                }
            } catch {
                print(error)
            }
        })
        
        let cancelAction = UIAlertAction(title: "NO".localized(), style: UIAlertAction.Style.cancel, handler: { (action) in
            self.passwordText.becomeFirstResponder()
        })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.view.endEditing(true)
        let password = self.passwordText.text!
        let sqlManager = SQLManager(databaseName: Database.name, password: password)
        CustomPassword.shared.password = password
        let connection = sqlManager.openConnection()
        
        if connection == nil {
            self.view.makeToast("Password incorrect. Please try again.".localized(), duration: 3.0, position: .top)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
            UIApplication.shared.keyWindow?.addSubview(controller.view)
            DispatchQueue.main.async {
                controller.loadTent {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}

//
// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.passwordText.layer.shadowColor = #colorLiteral(red: 0.262745098, green: 0.6274509804, blue: 0.7921568627, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.passwordText.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
