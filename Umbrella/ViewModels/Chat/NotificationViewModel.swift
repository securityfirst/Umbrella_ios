//
//  NotificationViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class NotificationViewModel {
    
    //
    // MARK: - Properties
    var service: UmbrellaMatrixRoomService
    var userLogged: UserMatrix!
    var sqlManager: SQLManager
    lazy var userMatrixDao: UserMatrixDao = {
        let userMatrixDao = UserMatrixDao(sqlProtocol: self.sqlManager)
        return userMatrixDao
    }()
    
    init() {
        self.service = UmbrellaMatrixRoomService(client: UmbrellaClient())
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        _ = self.userMatrixDao.createTable()
    }
    
    func joinRoom(roomId: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        self.userLogged = getUserLogged()
        service.joinRoom(accessToken: self.userLogged.accessToken, roomId: roomId, success: { response in
            success(response as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
    
    func leaveRoom(roomId: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        self.userLogged = getUserLogged()
        service.leaveRoom(accessToken: self.userLogged.accessToken, roomId: roomId, success: { response in
            success(response as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
    
    func getUserLogged() -> UserMatrix? {
        let users = userMatrixDao.list()
        return users.first
    }
}
