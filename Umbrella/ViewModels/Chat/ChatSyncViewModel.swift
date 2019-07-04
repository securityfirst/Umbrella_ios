//
//  ChatSyncViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class ChatSyncViewModel {
    
    var service: UmbrellaMatrixClientService
    var sqlManager: SQLManager
    lazy var userMatrixDao: UserMatrixDao = {
        let userMatrixDao = UserMatrixDao(sqlProtocol: self.sqlManager)
        return userMatrixDao
    }()
    
    init() {
        self.service = UmbrellaMatrixClientService(client: UmbrellaClient())
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        _ = self.userMatrixDao.createTable()
    }
    //
    // MARK: - Initializer
    init(service: UmbrellaMatrixClientService = UmbrellaMatrixClientService(client: UmbrellaClient())) {
        self.service = service
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    //
    // MARK: - Public Functions
    func sync(success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        let user = getUserLogged()
        
        if let user = user {
            service.sync(token: user.accessToken, success: { (object) in
                success(object as AnyObject)
            }, failure: { (response, object, error) in
                failure(response, object, error)
            })
        }
    }
    
    func getUserLogged() -> UserMatrix? {
        let users = userMatrixDao.list()
        return users.first
    }

}
