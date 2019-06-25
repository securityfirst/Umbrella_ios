//
//  PublicRoom.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct PublicRoom: Codable {
    let rooms: [PublicChunk]
    let totalRoomCountEstimate: Int
    
    enum CodingKeys: String, CodingKey {
        case rooms = "chunk"
        case totalRoomCountEstimate = "total_room_count_estimate"
    }
}

//Public room
struct PublicChunk: Codable {
    var roomId: String
    var name: String
    var topic: String
    var canonicalAlias: String
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case name = "name"
        case topic = "topic"
        case canonicalAlias = "canonical_alias"
    }
}
