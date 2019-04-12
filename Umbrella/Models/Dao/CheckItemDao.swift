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
        return self.sqlProtocol.create(table: CheckItem())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [CheckItem] {
        return self.sqlProtocol.select(withQuery: "SELECT id, name as [check], is_label, checklist_id FROM \(CheckItem.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: CheckItem.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: CheckItem) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(CheckItem.table) ('name', 'is_label', 'checklist_id') VALUES (\"\(object.name.replacingOccurrences(of: "\"", with: "'"))\", \(object.isLabel ? 1 : 0), \(object.checkListId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
