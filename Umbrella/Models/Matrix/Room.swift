//
//  Room.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct Room: Codable, Hashable, TableProtocol {
    var roomId: String?
    var preset: String?
    var roomAliasName: String?
    var name: String
    var topic: String
    var visibility: String?
    var invite: [String]?
    var canonicalAlias: String?
    
    init() {
        self.roomId = ""
        self.preset = ""
        self.roomAliasName = ""
        self.name = ""
        self.topic = ""
        self.visibility = ""
        self.invite = []
        self.canonicalAlias = ""
    }

    init(roomId: String = "", preset: String = "", roomAliasName: String = "", name: String, topic: String, visibility: String = "", invite: [String] = [""], canonicalAlias: String = "") {
        self.roomId = roomId
        self.preset = preset
        self.roomAliasName = roomAliasName
        self.name = name
        self.topic = topic
        self.visibility = visibility
        self.invite = invite
        self.canonicalAlias = canonicalAlias
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case preset = "preset"
        case roomAliasName = "room_alias_name"
        case name = "name"
        case topic = "topic"
        case visibility = "visibility"
        case invite = "invite"
        case canonicalAlias = "canonical_alias"
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "room"
    var tableName: String {
        return Room.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "room_id", type: .primaryStringKey),
            Column(name: "name", type: .string),
            Column(name: "topic", type: .string),
            Column(name: "canonical_alias", type: .string)
        ]
        return array
    }
    
    static func == (lhs: Room, rhs: Room) -> Bool {
        return lhs.roomId == rhs.roomId
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
