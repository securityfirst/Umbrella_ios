//
//  ChatNewContactViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 22/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatNewContactViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    lazy var chatGroupViewModel: ChatGroupViewModel = {
        let chatGroupViewModel = ChatGroupViewModel()
        return chatGroupViewModel
    }()
    
    lazy var chatInviteUserViewModel: ChatInviteUserViewModel = {
        let chatInviteUserViewModel = ChatInviteUserViewModel()
        return chatInviteUserViewModel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernameText.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        self.checkInternet()
    }
    
    func checkInternet() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reachability().monitorReachabilityChanges()
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        let status = Reachability().connectionStatus()
        switch status {
        case .unknown, .offline:
            self.saveButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.saveButton.isEnabled = false
            UIApplication.shared.keyWindow!.makeToast("You have no internet connection.".localized(), duration: 3.0, position: .center)
        case .online(.wwan), .online(.wiFi):
            self.saveButton.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.7411764706, blue: 0.2039215686, alpha: 1)
            self.saveButton.isEnabled = true
        }
    }
    
    func validateForm() -> Bool {
        var check = true
        
        if self.usernameText.text?.lengthOfBytes(using: .utf8) == 0 {
            check = false
        }
        
        if !check {
            UIApplication.shared.keyWindow!.makeToast("Enter username".localized(), duration: 2.5, position: .center)
        }
        
        return check
    }
    
    func searchUser(text: String) {
        self.activityIndicator.isHidden = false
        self.chatInviteUserViewModel.searchUser(text: text, success: { (response) in
            self.userTableView.isHidden = (self.chatInviteUserViewModel.usersArray.count == 0)
            self.activityIndicator.isHidden = (self.chatInviteUserViewModel.usersArray.count == 0)
            self.userTableView.reloadData()
        }, failure: { (response, object, error) in
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.userTableView.isHidden = true
            }
            print(error ?? "")
        })
    }

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
                // 812 on iPhone X, XS
                // 896 on iPhone XS Max or XR
                if UIScreen.main.bounds.height >= 812 {
                    self.bottomConstraint?.constant = (endFrame?.size.height)! - 30
                } else {
                    self.bottomConstraint?.constant = (endFrame?.size.height)! + 5
                }
            }
            
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if validateForm() {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
            controller.showLoading(view: self.view)
            
            let room = Room(preset: "private_chat", roomAliasName: "contact_room", name: self.usernameText.text!, topic: self.usernameText.text!, visibility: "private", invite: ["@\(self.usernameText.text!):comms.secfirst.org"])
            
            self.chatGroupViewModel.createRoom(room: room, success: { (publicRoom) in
                controller.closeLoading()
                self.dismiss(animated: true, completion: nil)
            }, failure: { (response, object, error) in
                controller.closeLoading()
                print(error ?? "")
            })
        }
    }
}

// MARK: - UITableViewDataSource
extension ChatNewContactViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatInviteUserViewModel.usersArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ChatInviteUserCell = (tableView.dequeueReusableCell(withIdentifier: "ChatInviteUserCell", for: indexPath) as? ChatInviteUserCell)!
        cell.configure(withViewModel: self.chatInviteUserViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChatNewContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = self.chatInviteUserViewModel.usersArray[indexPath.row]
        self.usernameText.text = user.displayName
        
        self.userTableView.isHidden = true
        self.activityIndicator.isHidden = true
    }
}

// MARK: - UITextFieldDelegate
extension ChatNewContactViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if updatedText.lengthOfBytes(using: .utf8) >= 3 {
                self.searchUser(text: updatedText)
            } else {
                self.userTableView.isHidden = true
                self.activityIndicator.isHidden = true
            }
            
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
