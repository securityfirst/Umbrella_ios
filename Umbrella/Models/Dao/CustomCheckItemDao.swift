//
//  CustomCheckItemDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 07/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct CustomCheckItemDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: CustomCheckItem())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [CustomCheckItem] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(CustomCheckItem.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: CustomCheckItem.table)
    }

    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: CustomCheckItem) -> Int64 {
        var sql = ""
        
        if object.id == -1 {
            sql = "INSERT OR REPLACE INTO \(CustomCheckItem.table) ('name', 'custom_checklist_id') VALUES (\"\(object.name)\", \(object.customChecklistId))"
        } else {
            sql = "INSERT OR REPLACE INTO \(CustomCheckItem.table) ('id', 'name', 'custom_checklist_id') VALUES (\(object.id), \"\(object.name)\", \(object.customChecklistId))"
        }
        
        let rowId = self.sqlProtocol.insert(withQuery: sql)
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// List of object
    ///
    /// - Returns: a list of object
    func listOfChecklist(checkListId: Int) -> [CustomCheckItem] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(CustomCheckItem.table) WHERE custom_checklist_id = \(checkListId)")
    }
    
    /// Delete CustomCheckItem of the database
    ///
    /// - Parameter customCheckItem: CustomCheckItem
    /// - Returns: bool
    func remove(_ object: CustomCheckItem) -> Bool {
        let sql = "DELETE FROM \(CustomCheckItem.table) WHERE id = \(object.id)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// Delete all CustomCheckItem in database
    ///
    /// - Parameter customChecklistId: Int
    /// - Returns: bool
    func removeAll(_ customChecklistId: Int) -> Bool {
        let sql = "DELETE FROM \(CustomCheckItem.table) WHERE custom_checklist_id = \(customChecklistId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
}
