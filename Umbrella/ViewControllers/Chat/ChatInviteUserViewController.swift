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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsField.cornerRadius = 3.0
        tagsField.spaceBetweenLines = 10
        tagsField.spaceBetweenTags = 10
        
        tagsField.numberOfLines = 2
        tagsField.maxHeight = 80.0
        
//        tagsField.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
//        tagsField.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //old padding
        
        tagsField.placeholder = "Username"
        tagsField.placeholderColor = .lightGray
        tagsField.placeholderAlwaysVisible = true
//        tagsField.backgroundColor = .lightGray
        tagsField.returnKeyType = .next
        tagsField.delimiter = ""
        tagsField.keyboardAppearance = .dark
        
        tagsField.textDelegate = self
        
        tagsField.onDidAddTag = { field, tag in
            print("onDidAddTag", tag.text)
            
            delay(0.25, closure: {
                let bottomOffset = CGPoint(x: 0, y: self.tagsField.contentSize.height - self.tagsField.bounds.size.height + self.tagsField.contentInset.bottom + 10)
                self.tagsField.setContentOffset(bottomOffset, animated: true)
            })
        }
        
        tagsField.onDidRemoveTag = { field, tag in
            print("onDidRemoveTag", tag.text)
        }
        
        tagsField.onDidChangeText = { _, text in
            print("onDidChangeText \(text)")
            
            if text?.count ?? 0 >= 3 {
                self.searchUser(text: text!)
            }
        }
        
        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo \(height)")
        }
        
        tagsField.onDidSelectTagView = { _, tagView in
            print("Select \(tagView)")
        }
        
        tagsField.onDidUnselectTagView = { _, tagView in
            print("Unselect \(tagView)")
        }
    }
    
    func searchUser(text: String) {
        self.chatInviteUserViewModel.searchUser(text: text, success: { (response) in
            
        }, failure: { (response, object, error) in
            print(error ?? "")
        })
    }
    
    @IBAction func sendAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
//        let country = self.chatInviteUserViewModel.usersArray[indexPath.row]
//        cell.textLabel?.text = country.name
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ChatInviteUserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
//        self.country = self.chatInviteUserViewModel.usersArray[indexPath.row]
//        self.locationText.text = self.country.name
    }
}

extension ChatInviteUserViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == tagsField {
//            anotherField.becomeFirstResponder()
//        }
        return true
    }
    
}
