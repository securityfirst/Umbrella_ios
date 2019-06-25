//
//  ChatGroupViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class ChatGroupViewModel {
    
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
    func publicRooms(accessToken: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        service.publicRooms(accessToken: accessToken, success: { (object) in
            let publicRoom = (object as? PublicRoom)!
            self.rooms = publicRoom.rooms
            success(publicRoom as AnyObject)
        }, failure: { (response, object, error) in
            failure(response, object, error)
        })
    }
}
