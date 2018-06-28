//
//  SegmentDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 25/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct SegmentDao: DaoProtocol {
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return SQLManager.shared.create(table: Segment())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Segment] {
        return SQLManager.shared.select(withQuery: "SELECT id, name as title, [index], content, category_id FROM \(Segment.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return SQLManager.shared.drop(tableName: Segment.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Segment) -> Int64 {
        let rowId = SQLManager.shared.insert(withQuery: "INSERT INTO \(Segment.table) ('name', 'index', 'content', 'category_id') VALUES (\"\(object.name ?? "")\", \(object.index ?? -1), \"\(object.content!.toBase64())\", \(object.categoryId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
