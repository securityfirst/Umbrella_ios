//
//  ChatInviteUserViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class ChatInviteUserViewModel {
    
    //
    // MARK: - Properties
    var userLogged: UserMatrix!
    var sqlManager: SQLManager
    lazy var userMatrixDao: UserMatrixDao = {
        let userMatrixDao = UserMatrixDao(sqlProtocol: self.sqlManager)
        return userMatrixDao
    }()
    var service: UmbrellaMatrixClientService
    var usersArray: [Any] = [Any]()
    
    init() {
        self.service = UmbrellaMatrixClientService(client: UmbrellaClient())
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        _ = self.userMatrixDao.createTable()
    }
    
    func searchUser(text: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        self.userLogged = getUserLogged()
        service.searchUser(token: self.userLogged.accessToken, text: text, success: { (response) in
            
            let searchUsers = (response as? SearchUser)!
            success(searchUsers as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
    
    func getUserLogged() -> UserMatrix? {
        let users = userMatrixDao.list()
        return users.first
    }
}
