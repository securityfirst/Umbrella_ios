//
//  FormDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 26/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct FormDao: DaoProtocol {
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return SQLManager.shared.create(table: Form())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Form] {
        return SQLManager.shared.select(withQuery: "SELECT * FROM \(Form.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return SQLManager.shared.drop(tableName: Form.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Form) -> Int64 {
        let rowId = SQLManager.shared.insert(withQuery: "INSERT INTO \(Form.table) ('name') VALUES (\"\(object.name)\")")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
