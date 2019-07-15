//
//  ChatSignInViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit
import SafariServices
import Localize_Swift

class ChatSignInViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var chatCredentialViewModel: ChatCredentialViewModel = {
        let chatCredentialViewModel = ChatCredentialViewModel()
        return chatCredentialViewModel
    }()
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatLoginScrollview: UIScrollView!
    @IBOutlet weak var loginHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var notSureOfYourPasswordLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var createButton: UIButton!
    
    var chatRegisterViewController: ChatRegisterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeSignInScreen), name: NSNotification.Name("RemoveSignInScreen"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
        self.chatLoginScrollview.contentSize = self.view.frame.size
        
        self.usernameText.setBottomBorder()
        self.passwordText.setBottomBorder()
        self.updateLanguage()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (self.view.tag != 99) {
            self.view.tag = 99
            self.loginHeightConstraint.constant = self.chatLoginScrollview.frame.size.height
            self.view.updateConstraints()
        }
    }
    
    //
    // MARK: - Functions
    
    @objc func updateLanguage() {
        self.title = "Chat".localized()
        self.usernameText.placeholder = "Username".localized()
        self.passwordText.placeholder = "Password".localized()
        
        let textString = "Not sure of your password?".localized() + " " + "Set a new one".localized()
        let range = (textString as NSString).range(of: "Set a new one".localized())
        let attributedString = NSMutableAttributedString(string: textString)
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1), range: range)
        self.notSureOfYourPasswordLabel.attributedText = attributedString
        
        self.signInButton.setTitle("SIGN IN".localized(), for: .normal)
        self.createButton.setTitle("CREATE ACCOUNT".localized(), for: .normal)
        
        let language = UserDefaults.standard.object(forKey: "Language")
        
        if let language: String = language as? String {
            // Arabic(ar) or Persian Farsi(fa)
            if language == "ar" || language == "fa" {
                self.usernameText.textAlignment = .right
                self.passwordText.textAlignment = .right
                self.notSureOfYourPasswordLabel.textAlignment = .right
            } else {
                self.usernameText.textAlignment = .left
                self.passwordText.textAlignment = .left
                self.notSureOfYourPasswordLabel.textAlignment = .left
            }
        }
    }
    
    @objc func removeSignInScreen() {
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
        
        if self.usernameText.text?.lengthOfBytes(using: .utf8) == 0 || self.passwordText.text?.lengthOfBytes(using: .utf8) == 0 {
            check = false
        }
        
        if !check {
            UIApplication.shared.keyWindow!.makeToast("Enter username and password.".localized(), duration: 2.5, position: .center)
        }
        
        return check
    }
    
    //
    // MARK: - Actions
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        let safariViewController = SFSafariViewController(url: URL(string: "https://riot.im/app/#/forgot_password")!)
        safariViewController.delegate = self
        self.present(safariViewController, animated: true)
    }
    
    @IBAction func signInAction(_ sender: Any) {
        self.keyboardWillBeHidden()
        
        if validateForm() {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
            controller.showLoading(view: self.view)
            
            self.chatCredentialViewModel.login(username: self.usernameText.text!, password: self.passwordText.text!, success: { (user) in
                DispatchQueue.main.async {
                    controller.closeLoading()
                    NotificationCenter.default.post(name: Notification.Name("RemoveCredentialScreen"), object: nil)
                }
            }, failure: { (response, object, error) in
                controller.closeLoading()
                UIApplication.shared.keyWindow!.makeToast("Username or password is invalid".localized(), duration: 2.5, position: .center)
                print(error ?? "")
            })
        }
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Chat", bundle: Bundle.main)
        self.chatRegisterViewController = (storyboard.instantiateViewController(withIdentifier: "ChatRegisterViewController") as? ChatRegisterViewController)!
        self.add(self.chatRegisterViewController)
    }
    
}

//
// MARK: - UITextFieldDelegate
extension ChatSignInViewController: UITextFieldDelegate {
    
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

//
// MARK: - SFSafariViewControllerDelegate
extension ChatSignInViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
