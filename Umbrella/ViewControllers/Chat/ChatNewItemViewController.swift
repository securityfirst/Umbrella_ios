//
//  ChatNewItemViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 08/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatNewItemViewController: UIViewController {

    var onNewContact: (() -> Void)?
    var onNewGroup: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func newContactAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.onNewContact?()
        }
    }
    
    @IBAction func newGroupAction(_ sender: Any) {
        self.dismiss(animated: true) {
            self.onNewGroup?()
        }
    }
    
    @IBAction func newOrganisationAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
