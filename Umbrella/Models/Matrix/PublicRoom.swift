//
//  PublicRoom.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct PublicRoom: Codable, TableProtocol {
    var roomId: String?
    let rooms: [Room]
    let totalRoomCountEstimate: Int
    
    init() {
        self.roomId = ""
        self.rooms = []
        self.totalRoomCountEstimate = 0
    }
    
    init(roomId: String) {
        self.roomId = roomId
        self.rooms = []
        self.totalRoomCountEstimate = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case roomId = "room_id"
        case rooms = "chunk"
        case totalRoomCountEstimate = "total_room_count_estimate"
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "public_room"
    var tableName: String {
        return PublicRoom.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "room_id", type: .primaryStringKey)
        ]
        return array
    }
}
