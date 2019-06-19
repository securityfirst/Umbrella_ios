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
    case matrixLogout
}

class AccountViewModel {
    
    //
    // MARK: - Properties
    var items: [(name: String, type: Any)]!
    var sqlManager: SQLManager
    lazy var userMatrixDao: UserMatrixDao = {
        let userMatrixDao = UserMatrixDao(sqlProtocol: self.sqlManager)
        return userMatrixDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        _ = userMatrixDao.createTable()
        self.loadItems()
    }
    
    func loadItems() {
        self.items = [
            (name: "Settings".localized(), type: AccountItem.settings),
            (name: "Set password".localized(), type: AccountItem.setPassword)
        ]
        
        if self.userMatrixDao.list().count > 0 {
            self.items.append((name: "Chat log out".localized(), type: AccountItem.matrixLogout))
        }
        
    }
    
    func isLogged() -> Bool {
        let users = userMatrixDao.list()
        return users.count > 0
    }
}
