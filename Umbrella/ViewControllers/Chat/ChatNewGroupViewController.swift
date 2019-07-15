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
    
    lazy var chatGroupViewModel: ChatGroupViewModel = {
        let chatGroupViewModel = ChatGroupViewModel()
        return chatGroupViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameText.becomeFirstResponder()
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
            
            let room = Room(preset: preset, roomAliasName: roomAliasName, name: self.nameText.text!, topic: self.nameText.text!, visibility: visibility, invite: [])
            
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
