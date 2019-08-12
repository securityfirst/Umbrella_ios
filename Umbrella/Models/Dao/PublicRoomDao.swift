//
//  PublicRoomDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 12/08/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct PublicRoomDao: DaoProtocol {
    
    //
    // MARK: - Properties
    let sqlProtocol: SQLProtocol
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameter sqlProtocol: SQLProtocol
    init(sqlProtocol: SQLProtocol) {
        self.sqlProtocol = sqlProtocol
    }
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return self.sqlProtocol.create(table: PublicRoom())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [PublicRoom] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(PublicRoom.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: PublicRoom.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: PublicRoom) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT OR REPLACE INTO \(PublicRoom.table) ('room_id') VALUES (\"\(object.roomId ?? "")\")")
        return rowId
    }
    
    /// Reset connection
    ///
    func resetConnection() {
        self.sqlProtocol.resetConnection()
    }
    
    //
    // MARK: - Custom functions
    
    func listRooms() -> [Room] {
        return self.sqlProtocol.select(withQuery: "SELECT room.room_id, room.name, room.topic, room.canonical_alias FROM \(PublicRoom.table), \(Room.table) WHERE \(PublicRoom.table).room_id = \(Room.table).room_id")
    }
}
