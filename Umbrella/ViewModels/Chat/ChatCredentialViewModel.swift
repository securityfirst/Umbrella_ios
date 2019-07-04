//
//  ChatLoginViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class ChatCredentialViewModel {
    
    var service: UmbrellaMatrixClientService
    fileprivate var userMatrix: UserMatrix!
    
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
    func login(username: String, password: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        service.login(username: username, password: password, type: "m.login.password", success: { (user) in
            self.userMatrix = (user as? UserMatrix)!
            self.userMatrix.username = username
            self.userMatrix.password = password
            _ = self.userMatrixDao.insert(self.userMatrix)
            success(user as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
    
    func logout(success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        if let user = userMatrixDao.list().first {
            service.logout(accessToken: user.accessToken, success: { _ in
                _ = self.userMatrixDao.removeAll()
                success("")
            }, failure: { (response, object, error) in
                let matrixError = (error as? MatrixError)!
                
                if matrixError.errorCode == "M_UNKNOWN_TOKEN" {
                    _ = self.userMatrixDao.removeAll()
                }
                
                failure(response, object, error)
            })
        }
    }
    
    func createUser(username: String, password: String, email: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        service.createUser(username: username, password: password, email: email, success: { (user) in
            self.userMatrix = (user as? UserMatrix)!
            _ = self.userMatrixDao.insert(self.userMatrix)
            success(user as AnyObject)
            
            if email.count > 0 {
                self.service.requestEmailToken(token: self.userMatrix.accessToken, email: email, success: { _ in
                }, failure: { (response, object, error) in
                })
            }
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
    
    func isLogged() -> Bool {
        let users = userMatrixDao.list()
        return users.count > 0
    }
    
    func getUserLogged() -> UserMatrix? {
        let users = userMatrixDao.list()
        return users.first
    }
}
