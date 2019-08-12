//
//  ChatGroupViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class ChatGroupViewModel {
    
    var userLogged: UserMatrix!
    var sqlManager: SQLManager
    var service: UmbrellaMatrixRoomService
    var rooms: [Room] = [Room]()
    
    lazy var publicRoomDao: PublicRoomDao = {
        let publicRoomDao = PublicRoomDao(sqlProtocol: self.sqlManager)
        return publicRoomDao
    }()
    
    lazy var roomDao: RoomDao = {
        let roomDao = RoomDao(sqlProtocol: self.sqlManager)
        return roomDao
    }()
    
    init() {
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        self.service = UmbrellaMatrixRoomService(client: UmbrellaClient())
    }
    
    //
    // MARK: - Initializer
    init(service: UmbrellaMatrixRoomService = UmbrellaMatrixRoomService(client: UmbrellaClient())) {
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        self.service = service
    }
    
    //
    // MARK: - Public Functions
    func publicRooms(success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        let roomsJoined = self.roomDao.list()
        let status = Reachability().connectionStatus()
        if status.description == "Offline" {
            self.rooms = self.publicRoomDao.listRooms()
            self.rooms.sort(by: {$0.name < $1.name })
            success(nil)
        } else {
            service.publicRooms(accessToken: userLogged.accessToken, success: { (object) in
                let publicRoom = (object as? PublicRoom)!
                
                for room in publicRoom.rooms {
                    
                    let result = roomsJoined.first(where: { $0.roomId == room.roomId })
                    
                    if result == nil {
                        _ = self.roomDao.insert(room)
                    }
                    
                    let publicRoom = PublicRoom(roomId: room.roomId!)
                    _ = self.publicRoomDao.insert(publicRoom)
                    
                }
                
                self.rooms = publicRoom.rooms
                self.rooms.sort(by: {$0.name < $1.name })
                success(publicRoom as AnyObject)
            }, failure: { (response, object, error) in
                failure(response, object, error)
            })
        }
    }
    
    func createRoom(room: Room, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        service.createRoom(accessToken: userLogged.accessToken, room: room, success: { (object) in
            success(object as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
}
