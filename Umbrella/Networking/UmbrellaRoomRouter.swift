//
//  UmbrellaRoomRouter.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

enum UmbrellaRoomRouter: Router {
    case createRoom(accessToken: String, room: Room)
    case publicRooms(accessToken: String)
}

extension UmbrellaRoomRouter {
    
    var method: String {
        switch self {
        case .createRoom:
            return "POST"
        case .publicRooms:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .createRoom(let accessToken):
            return "createRoom?access_token=\(accessToken)"
        case .publicRooms(let accessToken):
            return "publicRooms?access_token=\(accessToken)&limit=10"
        }
    }
    
    var headers: [String: String] {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .createRoom(_, let room):
            return [
                "preset": room.preset,
                "room_alias_name": room.roomAliasName,
                "name": room.name,
                "topic": room.topic,
                "visibility": room.visibility,
                "invite": room.invite
            ]
        case .publicRooms:
            return nil
        }
    }
    
    var url: URL {
        switch self {
        case .createRoom:
            return URL(string: "\(Matrix.baseUrlString)\(path)")!
        case .publicRooms:
            return URL(string: "\(Matrix.baseUrlString)\(path)")!
        }
    }
}
