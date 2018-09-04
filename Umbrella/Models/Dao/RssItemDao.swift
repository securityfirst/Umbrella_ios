//
//  RssDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct RssItemDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: RssItem())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [RssItem] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(RssItem.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: RssItem.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: RssItem) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(RssItem.table) ('url') VALUES (\"\(object.url)\")")
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
}
