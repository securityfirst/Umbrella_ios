//
//  ChecklistCheckedDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 26/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct ChecklistCheckedDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: ChecklistChecked())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [ChecklistChecked] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(ChecklistChecked.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: ChecklistChecked.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: ChecklistChecked) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(ChecklistChecked.table) ('subcategory_name', 'subcategory_id', 'difficulty_id', 'checklist_id', 'item_id', 'total_items_checklist', 'language_id', 'created_at', 'is_matrix', 'user_matrix') VALUES (\"\(object.subCategoryName)\", \(object.subCategoryId), \(object.difficultyId), \(object.checklistId), \(object.itemId), \(object.totalItemsChecklist), \(object.languageId), \"\(object.createdAt)\", \(object.isMatrix), \"\(object.userMatrix)\")")
        return rowId
    }
    
    //
    // MARK: - Custom functions
 
    /// Reset connection
    ///
    func resetConnection() {
        self.sqlProtocol.resetConnection()
    }
    
    /// Delete checklistChecked in database
    ///
    /// - Parameter checklistChecked: checklistChecked
    /// - Returns: bool
    func remove(_ checklistChecked: ChecklistChecked) -> Bool {
        let sql = "DELETE FROM \(ChecklistChecked.table) WHERE subcategory_id = \(checklistChecked.subCategoryId) AND difficulty_id = \(checklistChecked.difficultyId) AND checklist_id = \(checklistChecked.checklistId) AND item_id = \(checklistChecked.itemId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// Delete all checklistChecked in database
    ///
    /// - Parameter checklistChecked: checklistChecked
    /// - Returns: bool
    func removeAllChecks(_ checklistChecked: ChecklistChecked) -> Bool {
        let sql = "DELETE FROM \(ChecklistChecked.table) WHERE subcategory_id = \(checklistChecked.subCategoryId) AND difficulty_id = \(checklistChecked.difficultyId) AND checklist_id = \(checklistChecked.checklistId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list(checklistId: Int) -> [ChecklistChecked] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(ChecklistChecked.table) WHERE checklist_id = \(checklistId)")
    }
    
    /// Get all item checked in group by checklist_id
    ///
    /// - Returns: [ChecklistChecked]
    func reportOfItemsChecked() -> [ChecklistChecked] {
        return self.sqlProtocol.select(withQuery: "SELECT subcategory_name, subcategory_id, difficulty_id, checklist_id, count(case when item_id > 0 then 1 else null end) as total_checked, total_items_checklist, language_id, created_at, is_matrix, user_matrix FROM \(ChecklistChecked.table) GROUP BY checklist_id ORDER BY subcategory_name desc;")
    }
}
