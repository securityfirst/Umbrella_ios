//
//  ChatViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 07/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Chat".localized()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
