//
//  PathwayChecklistCheckedDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct PathwayChecklistCheckedDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: PathwayChecklistChecked())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [PathwayChecklistChecked] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(PathwayChecklistChecked.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: PathwayChecklistChecked.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: PathwayChecklistChecked) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(PathwayChecklistChecked.table) ('name', 'checklist_id', 'item_id', 'total_items_checklist', 'language_id') VALUES (\"\(object.name)\", \(object.checklistId), \(object.itemId), \(object.totalItemsChecklist), \(object.languageId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// Reset connection
    ///
    func resetConnection() {
        self.sqlProtocol.resetConnection()
    }
    
    /// Delete pathwayChecklistChecked in database
    ///
    /// - Parameter PathwayChecklistChecked
    /// - Returns: bool
    func remove(_ pathwayChecklistChecked: PathwayChecklistChecked) -> Bool {
        let sql = "DELETE FROM \(PathwayChecklistChecked.table) WHERE checklist_id = \(pathwayChecklistChecked.checklistId) AND item_id = \(pathwayChecklistChecked.itemId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// Delete all pathwayChecklistChecked in database
    ///
    /// - Parameter Checklist
    /// - Returns: bool
    func removeAllChecks(_ checklist: CheckList) -> Bool {
        let sql = "DELETE FROM \(PathwayChecklistChecked.table) WHERE checklist_id = \(checklist.id)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list(checklistId: Int) -> [PathwayChecklistChecked] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(PathwayChecklistChecked.table) WHERE checklist_id = \(checklistId)")
    }
}
