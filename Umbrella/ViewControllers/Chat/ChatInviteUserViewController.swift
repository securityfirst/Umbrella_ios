//
//  ChatInviteUserViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatInviteUserViewController: UIViewController {
    
    @IBOutlet weak var tagsField: WSTagsField!
    lazy var chatInviteUserViewModel: ChatInviteUserViewModel = {
        let chatInviteUserViewModel = ChatInviteUserViewModel()
        return chatInviteUserViewModel
    }()
    
    @IBOutlet weak var sendBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var inviteTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var onInviteUser: (([WSTag]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
        
        tagsField.cornerRadius = 3.0
        tagsField.spaceBetweenLines = 15
        tagsField.spaceBetweenTags = 10
        
        tagsField.numberOfLines = 2
        tagsField.maxHeight = 80.0
        
        tagsField.placeholder = "Username"
        tagsField.placeholderColor = .lightGray
        tagsField.placeholderAlwaysVisible = true
        tagsField.returnKeyType = .done
        tagsField.delimiter = ""
        tagsField.tintColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
        tagsField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        tagsField.textDelegate = self
        tagsField.beginEditing()
        tagsField.onDidAddTag = { field, tag in
            delay(0.10, closure: {
                let bottomOffset = CGPoint(x: 0, y: self.tagsField.contentSize.height - self.tagsField.bounds.size.height + self.tagsField.contentInset.bottom + 10)
                self.tagsField.setContentOffset(bottomOffset, animated: true)
            })
        }
        
        tagsField.onDidChangeText = { _, text in
            self.inviteTableView.isHidden = true
            if text?.count ?? 0 >= 3 {
                self.activityIndicator.isHidden = false
                self.searchUser(text: text!)
            } else {
                self.activityIndicator.isHidden = true
            }
        }

    }
    
    func searchUser(text: String) {
        self.chatInviteUserViewModel.searchUser(text: text, success: { (response) in
            
            self.inviteTableView.isHidden = (self.chatInviteUserViewModel.usersArray.count == 0)
            self.activityIndicator.isHidden = (self.chatInviteUserViewModel.usersArray.count == 0)
            
            self.inviteTableView.reloadData()
        }, failure: { (response, object, error) in
            DispatchQueue.main.async {
                self.activityIndicator.isHidden = true
                self.inviteTableView.isHidden = true
            }
            print(error ?? "")
        })
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
                // 812 on iPhone X, XS
                // 896 on iPhone XS Max or XR
                if UIScreen.main.bounds.height >= 812 {
                    self.bottomConstraint?.constant = (endFrame?.size.height)! - 34
                } else {
                    self.bottomConstraint?.constant = (endFrame?.size.height)!
                }
            }
            
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
        if sendBarButtonItem.title == "Send" {
            self.view.endEditing(true)
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
            controller.showLoading(view: self.view)
            
            var hasError = false
            for tag in tagsField.tags {
                self.chatInviteUserViewModel.inviteUser(userId: "@\(tag.text):comms.secfirst.org", success: { (response) in
                }, failure: { (response, object, error) in
                    print(error ?? "")
                    hasError = true
                })
            }
            
            delay(Double(tagsField.tags.count + 2)) {
                controller.closeLoading()
                
                var message = "Users invited."
                if hasError {
                    message = "Some users are already in the room."
                }
                UIApplication.shared.keyWindow!.makeToast(message, duration: 3.0, position: .center)
                self.dismiss(animated: true, completion: nil)
            }
            
        } else {
            self.onInviteUser?(tagsField!.tags)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension ChatInviteUserViewController: UITableViewDataSource {
    
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
extension ChatInviteUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let user = self.chatInviteUserViewModel.usersArray[indexPath.row]
        tagsField.text = ""
        tagsField.addTag(user.displayName)
    }
}

extension ChatInviteUserViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}
