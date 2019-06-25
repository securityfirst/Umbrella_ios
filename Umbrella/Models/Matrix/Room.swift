//
//  Room.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct Room: Codable {
    var preset: String
    var roomAliasName: String
    var name: String
    var topic: String
    var visibility: String
    var invite: [String]
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case preset = "preset"
        case roomAliasName = "room_alias_name"
        case name = "name"
        case topic = "topic"
        case visibility = "visibility"
        case invite = "invite"
    }
}

struct RoomResponse: Codable {
    var roomId: String
    var roomAlias: String
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case roomAlias = "room_alias"
    }
}

//{
//    "preset": "public_chat",
//    "room_alias_name": "umbrella_public3",
//    "name": "Umbrella Public",
//    "topic": "Dev Public room",
//    "visibility": "public",
//    "invite": []
// response
//"room_id": "!RINKVHsxdXROAMVVsy:comms.secfirst.org",
//"room_alias": "#umbrella_public6:comms.secfirst.org"
//}
//}
