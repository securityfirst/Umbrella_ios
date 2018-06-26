//
//  CheckListDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 26/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct CheckListDao: DaoProtocol {
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return SQLManager.shared.create(table: CheckList())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [CheckList] {
        return SQLManager.shared.select(withQuery: "SELECT * FROM \(CheckList.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return SQLManager.shared.drop(tableName: CheckList.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: CheckList) -> Int64 {
        let rowId = SQLManager.shared.insert(withQuery: "INSERT INTO \(CheckList.table) ('index', 'category_id') VALUES (\(object.index ?? -1), \(object.categoryId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
