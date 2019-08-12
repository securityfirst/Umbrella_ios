//
//  ChatRegisterViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class ChatRegisterViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var chatCredentialViewModel: ChatCredentialViewModel = {
        let chatCredentialViewModel = ChatCredentialViewModel()
        return chatCredentialViewModel
    }()
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatRegisterScrollview: UIScrollView!
    @IBOutlet weak var registerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmPasswordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    var chatSignInViewController: ChatSignInViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeRegisterScreen), name: NSNotification.Name("RemoveRegisterScreen"), object: nil)
        
        self.chatRegisterScrollview.contentSize = self.view.frame.size
        
        self.usernameText.setBottomBorder()
        self.passwordText.setBottomBorder()
        self.confirmPasswordText.setBottomBorder()
        self.emailText.setBottomBorder()
        self.updateLanguage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.view.tag != 99) {
            self.view.tag = 99
            self.registerHeightConstraint.constant = self.chatRegisterScrollview.frame.size.height
            self.view.updateConstraints()
        }
        
    }
    
    //
    // MARK: - Functions
    
    @objc func updateLanguage() {
        self.title = "Chat".localized()
        self.usernameText.placeholder = "Username".localized()
        self.passwordText.placeholder = "Password".localized()
        self.confirmPasswordText.placeholder = "Confirm".localized()
        self.emailText.placeholder = "Email (Optional)".localized()
        
        //        self.notSureOfYourPasswordLabel.attributedText
        
        self.signInButton.setTitle("SIGN IN INSTEAD".localized(), for: .normal)
        self.registerButton.setTitle("REGISTER".localized(), for: .normal)
        
        let language = UserDefaults.standard.object(forKey: "Language")
        
        if let language: String = language as? String {
            // Arabic(ar) or Persian Farsi(fa)
            if language == "ar" || language == "fa" {
                self.usernameText.textAlignment = .right
                self.passwordText.textAlignment = .right
                self.confirmPasswordText.textAlignment = .right
                self.emailText.textAlignment = .right
            } else {
                self.usernameText.textAlignment = .left
                self.passwordText.textAlignment = .left
                self.confirmPasswordText.textAlignment = .left
                self.emailText.textAlignment = .left
            }
        }
    }
    
    @objc func removeRegisterScreen() {
        self.remove()
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
                self.bottomConstraint?.constant = (endFrame?.size.height)! - 48
            }
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    /// Hidden the keyboard
    func keyboardWillBeHidden() {
        self.view.endEditing(true)
    }
    
    func validateForm() -> Bool {
        var check = true
        var message = ""
        
        if self.usernameText.text?.lengthOfBytes(using: .utf8) == 0 || self.passwordText.text?.lengthOfBytes(using: .utf8) == 0 || self.confirmPasswordText.text?.lengthOfBytes(using: .utf8) == 0 {
            message = "Enter username, password and confirm.".localized()
            check = false
        } else if !self.passwordText.text!.contains(self.confirmPasswordText.text!) {
            check = false
            message = "Passwords do not match.".localized()
        } else if self.passwordText.text!.count < 8 {
            check = false
            message = "Password too short.".localized()
        } else if !NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: self.passwordText.text!) || !NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: self.confirmPasswordText.text!) {
            check = false
            message = "Password must have at least one digit.".localized()
        } else if !NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: self.passwordText.text!) || !NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: self.confirmPasswordText.text!) {
            check = false
            message = "Password must have at least one capital letter.".localized()
        }
        
        if (self.emailText.text?.lengthOfBytes(using: .utf8))! > 0 {
            if !self.emailText.text!.isValidEmail {
                check = false
                message = "Email is invalid.".localized()
            }
        }
        
        if !check {
            UIApplication.shared.keyWindow!.makeToast(message.localized(), duration: 2.5, position: .center)
        }
        
        return check
    }
    
    //
    // MARK: - Actions
    
    @IBAction func registerAction(_ sender: Any) {
        if validateForm() {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
            controller.showLoading(view: self.view)
            
            self.chatCredentialViewModel.createUser(username: self.usernameText.text!, password: self.passwordText.text!, email: self.emailText.text!, success: { (user) in
                DispatchQueue.main.async {
                    controller.closeLoading()
                    NotificationCenter.default.post(name: Notification.Name("RemoveCredentialScreen"), object: nil)
                }
            }, failure: { (response, object, error) in
                controller.closeLoading()
                DispatchQueue.main.async {
                    let matrixError = error as? MatrixError
                    UIApplication.shared.keyWindow!.makeToast(matrixError?.error.localized(), duration: 2.5, position: .center)
                }
            })
        }
    }
    
    @IBAction func signInAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Chat", bundle: Bundle.main)
        self.chatSignInViewController = (storyboard.instantiateViewController(withIdentifier: "ChatSignInViewController") as? ChatSignInViewController)!
        self.add(self.chatSignInViewController)
    }
    
}

//
// MARK: - UITextFieldDelegate
extension ChatRegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.shadowColor = #colorLiteral(red: 0.262745098, green: 0.6274509804, blue: 0.7921568627, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
