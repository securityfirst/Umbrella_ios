//
//  AccountViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

enum AccountItem : String {
    case settings
    case mask
    case setPassword
    case switchRepo
}

class AccountViewModel {
    
    //
    // MARK: - Properties
    var items: [(name: String, type: Any)]!
    
    //
    // MARK: - Init
    init() {
        loadItems()
    }
    
    func loadItems() {
        self.items = [
            (name: "Settings".localized(), type: AccountItem.settings),
            //            (name: "Mask", type: AccountItem.mask),
            (name: "Set password".localized(), type: AccountItem.setPassword)
            //            (name: "Switch repo", type: AccountItem.switchRepo)
        ]
    }
}
