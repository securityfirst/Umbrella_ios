//
//  ChatViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 07/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class ChatViewController: UIViewController {

    //
    // MARK: - Properties
    var navigationItemCustom: NavigationItemCustom!
    var chatSignInViewController: ChatSignInViewController!
    lazy var chatCredentialViewModel: ChatCredentialViewModel = {
        let chatCredentialViewModel = ChatCredentialViewModel()
        return chatCredentialViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Chat".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItemCustom = NavigationItemCustom(viewController: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeCredentialScreen), name: NSNotification.Name("RemoveCredentialScreen"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItemCustom.showItems(true)
        
        if !self.chatCredentialViewModel.isLogged() {
            let storyboard = UIStoryboard(name: "Chat", bundle: Bundle.main)
            self.chatSignInViewController = (storyboard.instantiateViewController(withIdentifier: "ChatSignInViewController") as? ChatSignInViewController)!
            self.add(self.chatSignInViewController)
            self.navigationItem.rightBarButtonItem = nil
        } else {
            let modeBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.newMessage))
            self.navigationItem.rightBarButtonItem  = modeBarButton
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItemCustom.showItems(false)
    }
    
    //
    // MARK: - Functions
    
    @objc func newMessage() {
        self.title = "Chat".localized()
    }
    
    @objc func updateLanguage() {
        self.title = "Chat".localized()
    }
    
    @objc func removeCredentialScreen() {
        self.children.forEach({
            $0.willMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        })
        
        let modeBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.newMessage))
        self.navigationItem.rightBarButtonItem  = modeBarButton
    }
    
    //
    // MARK: - Actions
}
