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
    var service: UmbrellaMatrixRoomService
    var rooms: [PublicChunk] = [PublicChunk]()
    
    init() {
        self.service = UmbrellaMatrixRoomService(client: UmbrellaClient())
    }
    
    //
    // MARK: - Initializer
    init(service: UmbrellaMatrixRoomService = UmbrellaMatrixRoomService(client: UmbrellaClient())) {
        self.service = service
    }
    
    //
    // MARK: - Public Functions
    func publicRooms(success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        service.publicRooms(accessToken: userLogged.accessToken, success: { (object) in
            let publicRoom = (object as? PublicRoom)!
            self.rooms = publicRoom.rooms
            self.rooms.sort(by: {$0.name < $1.name })
            success(publicRoom as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
    
    func createRoom(room: Room, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        service.createRoom(accessToken: userLogged.accessToken, room: room, success: { (object) in
            success(object as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
}
