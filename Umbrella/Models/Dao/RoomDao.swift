//
//  RoomDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 12/08/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct RoomDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: Room())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Room] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(Room.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: Room.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Room) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT OR REPLACE INTO \(Room.table) ('room_id', 'name', 'topic', 'canonical_alias') VALUES (\"\(object.roomId ?? "")\", \"\(object.name)\", \"\(object.topic)\", \"\(object.canonicalAlias ?? "")\")")
        return rowId
    }
    
    /// Reset connection
    ///
    func resetConnection() {
        self.sqlProtocol.resetConnection()
    }
    
    //
    // MARK: - Custom functions

}
