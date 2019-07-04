//
//  UmbrellaRoomRouter.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

enum RoomTypeMessage: String {
    case text = "m.text"
    case file = "m.file"
}

enum UmbrellaRoomRouter: Router {
    case createRoom(accessToken: String, room: Room)
    case publicRooms(accessToken: String)
    case getMessages(accessToken: String, roomId: String, dir: String, from: String)
    case sendMessage(accessToken: String, roomId: String, type: String, message: String, url: String)
}

extension UmbrellaRoomRouter {
    
    var method: String {
        switch self {
        case .createRoom:
            return "POST"
        case .publicRooms:
            return "GET"
        case .getMessages:
            return "GET"
        case .sendMessage:
            return "POST"
        }
    }
    
    var path: String {
        switch self {
        case .createRoom(let accessToken):
            return "createRoom?access_token=\(accessToken)"
        case .publicRooms(let accessToken):
            return "publicRooms?access_token=\(accessToken)&limit=10"
        case .getMessages(let accessToken, let roomId, let dir, let from):
            
            if from.count > 0 {
                return "rooms/\(roomId)/messages?access_token=\(accessToken)&dir=\(dir)&from=\(from)&limit=100"
            }
            
            return "rooms/\(roomId)/messages?access_token=\(accessToken)&dir=\(dir)&limit=100"
        case .sendMessage(let accessToken, let roomId, _, _, _):
            return "rooms/\(roomId)/send/m.room.message?access_token=\(accessToken)"
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
        case .getMessages:
            return nil
        case .sendMessage(_, _, let type, let message, let url):
            
            if url.count > 0 {
                return [
                    "msgtype": type,
                    "body": message,
                    "url": url
                ]
            }
            
            return [
                "msgtype": type,
                "body": message
            ]
        }
    }
    
    var url: URL {
        switch self {
        case .createRoom, .publicRooms, .getMessages, .sendMessage:
            return URL(string: "\(Matrix.baseUrlString)client/r0/\(path)")!
        }
    }
}
