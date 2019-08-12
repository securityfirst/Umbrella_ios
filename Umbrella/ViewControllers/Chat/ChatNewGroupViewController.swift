//
//  ChatNewGroupViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatNewGroupViewController: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var inviteUserLabel: UILabel!
    
    lazy var chatGroupViewModel: ChatGroupViewModel = {
        let chatGroupViewModel = ChatGroupViewModel()
        return chatGroupViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameText.becomeFirstResponder()
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
            self.createButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            self.createButton.isEnabled = false
            UIApplication.shared.keyWindow!.makeToast("You have no internet connection.".localized(), duration: 3.0, position: .center)
        case .online(.wwan), .online(.wiFi):
            self.createButton.backgroundColor = #colorLiteral(red: 0.5294117647, green: 0.7411764706, blue: 0.2039215686, alpha: 1)
            self.createButton.isEnabled = true
        }
    }
    
    func validateForm() -> Bool {
        var check = true
        
        if self.nameText.text?.lengthOfBytes(using: .utf8) == 0 || self.typeText.text?.lengthOfBytes(using: .utf8) == 0 {
            check = false
        }
        
        if !check {
            UIApplication.shared.keyWindow!.makeToast("Enter name and type.".localized(), duration: 2.5, position: .center)
        }
        
        return check
    }
    
    @IBAction func typeAction(_ sender: Any) {
        UIAlertController.alertSheet(title: "", message: "Type".localized(), buttons: ["Public", "Private"], dismiss: { (option) in
            if option == 0 {
                self.typeText.text = "Public".localized()
            } else if option == 1 {
                self.typeText.text = "Private".localized()
            }
        }, cancel: {
            print("cancel")
        })
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAction(_ sender: Any) {
        
        if validateForm() {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
            controller.showLoading(view: self.view)
            
            var preset = ""
            var roomAliasName = ""
            var visibility = ""
            if self.typeText.text == "Public".localized() {
                preset = "public_chat"
                visibility = "public"
            } else {
                preset = "private_chat"
                visibility = "private"
            }
            
            roomAliasName = self.nameText.text!.replacingOccurrences(of: " ", with: "").lowercased()
            
            var inviteUser = [String]()
            if self.inviteUserLabel.text != "Optional Invite users" {
                
                if let users = self.inviteUserLabel.text?.components(separatedBy: " ") {
                    for user in users {
                        inviteUser.append("@\(user):comms.secfirst.org")
                    }
                }
                
            }
            
            let room = Room(preset: preset, roomAliasName: roomAliasName, name: self.nameText.text!, topic: self.nameText.text!, visibility: visibility, invite: inviteUser)
            
            self.chatGroupViewModel.createRoom(room: room, success: { (publicRoom) in
                controller.closeLoading()
                self.dismiss(animated: true, completion: nil)
            }, failure: { (response, object, error) in
                controller.closeLoading()
                print(error ?? "")
            })
        }
    }
    
    @IBAction func inviteUserAction(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Chat", bundle: Bundle.main)
        let navigationChatInviteUser = (storyboard.instantiateViewController(withIdentifier: "NavigationChatInviteUser") as? UINavigationController)!
        
        let chatInviteUserViewController = (navigationChatInviteUser.viewControllers.first! as? ChatInviteUserViewController)!
        
        chatInviteUserViewController.sendBarButtonItem.title = "OK"
        chatInviteUserViewController.onInviteUser = { tags in
            
            var users = ""
            for (index, tag) in tags.enumerated() {
                if index == 0 {
                    users += "\(tag.text)"
                } else {
                    users += " \(tag.text)"
                }
            }
            
            if users.count > 0 {
                self.inviteUserLabel.text = users
            }
            
            self.nameText.becomeFirstResponder()
        }
        self.present(navigationChatInviteUser, animated: true)
        
    }
    
}
