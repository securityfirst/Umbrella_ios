//
//  CustomChecklistCheckedDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 07/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct CustomChecklistCheckedDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: CustomChecklistChecked())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [CustomChecklistChecked] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(CustomChecklistChecked.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: CustomChecklistChecked.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: CustomChecklistChecked) -> Int64 {
        
        var sql = ""
        
        if object.id == -1 {
            sql = "INSERT OR REPLACE INTO \(CustomChecklistChecked.table) ('custom_checklist_id', 'item_id') VALUES (\(object.customChecklistId), \(object.itemId))"
        } else {
            sql = "INSERT OR REPLACE INTO \(CustomChecklistChecked.table) ('id', 'custom_checklist_id', 'item_id') VALUES (\(object.id), \(object.customChecklistId), \(object.itemId))"
        }
        
        let rowId = self.sqlProtocol.insert(withQuery: sql)
        
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: CustomCheckItem) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(CustomChecklistChecked.table) ('custom_checklist_id', 'item_id') VALUES (\(object.customChecklistId), \(object.id))")
        return rowId
    }
    
    /// Delete all CustomChecklistChecked in database
    ///
    /// - Parameter customChecklistChecked: CustomChecklistChecked
    /// - Returns: bool
    func removeAll(_ customChecklistId: Int) -> Bool {
        let sql = "DELETE FROM \(CustomChecklistChecked.table) WHERE custom_checklist_id = \(customChecklistId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// Delete CustomChecklistChecked with itemId in database
    ///
    /// - Parameter itemId: Int
    /// - Returns: bool
    func remove(_ itemId: Int) -> Bool {
        let sql = "DELETE FROM \(CustomChecklistChecked.table) WHERE item_id = \(itemId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func listOfCustomChecklist(_ customChecklistId: Int) -> [CustomChecklistChecked] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(CustomChecklistChecked.table) WHERE custom_checklist_id = \(customChecklistId)")
    }
}
