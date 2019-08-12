//
//  MessageDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 12/08/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct MessageDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: Message())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Message] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(Message.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: Message.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Message) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT OR REPLACE INTO \(Message.table) ('event_id', 'room_id', 'user_id', 'type', 'text', 'url', 'timestamp') VALUES (\"\(object.eventId)\", \"\(object.roomId)\", \"\(object.userId)\", \"\(object.content.msgtype ?? "")\", \"\(object.content.body ?? "")\", \"\(object.content.url ?? "")\", \(object.originTime))")
        return rowId
    }
    
    /// Reset connection
    ///
    func resetConnection() {
        self.sqlProtocol.resetConnection()
    }
    
    //
    // MARK: - Custom functions
    
    func listRoomId(roomId: String) -> [Message] {
        let object = self.sqlProtocol.select(withQuery: "SELECT * FROM \(Message.table) WHERE room_id = \"\(roomId)\"")
    
        var messages = [Message]()
        for msg in object {
            let content = Content(text: (msg["text"] as? String)!, type: (msg["type"] as? String)!, url: (msg["url"] as? String)!)
            
            let message = Message(eventId: (msg["event_id"] as? String)!, roomId: (msg["room_id"] as? String)!, userId: (msg["user_id"] as? String)!, originTime: Int((msg["timestamp"] as? Int64)!), content: content)
            messages.append(message)
        }
        return messages
    }
}
