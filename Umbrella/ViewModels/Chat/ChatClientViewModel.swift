//
//  ChatClientViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class ChatClientViewModel {
    
    var service: UmbrellaMatrixClientService
    var sqlManager: SQLManager
    var sync: Sync?
    var rooms: [PublicChunk] = [PublicChunk]()
    
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
            self.rooms.removeAll()
            service.sync(token: user.accessToken, success: { (object) in
                self.sync = (object as? Sync)!
                
                for dic in (self.sync?.rooms.join)! {
                    
                    let joinEvents: [JoinEvent] = dic.value.timeline.joinEvent.filter { $0.type == "m.room.name" }
                    
                    for joinEvent in joinEvents {
                    let publicChunk = PublicChunk(roomId: dic.key, name: joinEvent.content.name!, topic: "", canonicalAlias: "")
                        self.rooms.append(publicChunk)
                    }
                }
                success(object as AnyObject)
            }, failure: { (response, object, error) in
                failure(response, object, error)
            })
        }
    }
    
    func removePublicRooms(publicRoomList: [PublicChunk]) {
        
        for publiChunk in publicRoomList {
            for local in self.rooms where publiChunk.roomId == local.roomId {
                self.rooms.removeObject(obj: local)
                break
            }
        }
    }
    
    func getUserLogged() -> UserMatrix? {
        let users = userMatrixDao.list()
        return users.first
    }

}
