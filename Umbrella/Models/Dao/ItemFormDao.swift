//
//  ItemFormDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 26/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct ItemFormDao: DaoProtocol {
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return SQLManager.shared.create(table: ItemForm())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [ItemForm] {
        return SQLManager.shared.select(withQuery: "SELECT * FROM \(ItemForm.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return SQLManager.shared.drop(tableName: ItemForm.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: ItemForm) -> Int64 {
        let rowId = SQLManager.shared.insert(withQuery: "INSERT INTO \(ItemForm.table) ('name', 'type', 'label', 'hint', 'screen_id') VALUES (\"\(object.name)\", \"\(object.type)\", \"\(object.label)\", \"\(object.hint)\", \(object.screenId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
