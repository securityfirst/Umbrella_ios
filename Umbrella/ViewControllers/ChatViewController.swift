//
//  ChatViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 07/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    var navigationItemCustom: NavigationItemCustom!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Chat".localized()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItemCustom = NavigationItemCustom(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItemCustom.showItems(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItemCustom.showItems(false)
    }
}
