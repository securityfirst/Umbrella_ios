//
//  ScreenDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 26/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct ScreenDao: DaoProtocol {
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return SQLManager.shared.create(table: Screen())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Screen] {
        return SQLManager.shared.select(withQuery: "SELECT * FROM \(Screen.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return SQLManager.shared.drop(tableName: Screen.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Screen) -> Int64 {
        let rowId = SQLManager.shared.insert(withQuery: "INSERT INTO \(Screen.table) ('name', 'form_id') VALUES (\"\(object.name)\", \(object.formId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
