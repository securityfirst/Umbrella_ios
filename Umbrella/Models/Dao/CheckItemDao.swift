//
//  CheckItemDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 26/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct CheckItemDao: DaoProtocol {
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return SQLManager.shared.create(table: CheckItem())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [CheckItem] {
        return SQLManager.shared.select(withQuery: "SELECT * FROM \(CheckItem.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return SQLManager.shared.drop(tableName: CheckItem.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: CheckItem) -> Int64 {
        let rowId = SQLManager.shared.insert(withQuery: "INSERT INTO \(CheckItem.table) ('name', 'is_checked', 'category_id') VALUES (\"\(object.name)\", \(object.isChecked ?? false ? 1 : 0), \(object.categoryId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
