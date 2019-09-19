//
//  CustomChecklistDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 07/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct CustomChecklistDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: CustomChecklist())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [CustomChecklist] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(CustomChecklist.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: CustomChecklist.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: CustomChecklist) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(CustomChecklist.table) ('name', 'language_id') VALUES (\"\(object.name ?? "")\", \(object.languageId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// List of object
    ///
    /// - Returns: a list of object
    func listOfLanguage(languageId: Int) -> [CustomChecklist] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(CustomChecklist.table) WHERE language_id = \(languageId)")
    }
    
    /// Delete CustomChecklist of the database
    ///
    /// - Parameter customChecklist: CustomChecklist
    /// - Returns: bool
    func remove(_ object: CustomChecklist) -> Bool {
        let sql = "DELETE FROM \(CustomChecklist.table) WHERE id = \(object.id)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// Get Checklist
    ///
    /// - Returns: CheckList
    func getCustomChecklist(id: Int) -> CustomChecklist? {
        let objects: [CustomChecklist?] = self.sqlProtocol.select(withQuery: "SELECT * FROM \(CustomChecklist.table) WHERE id = \(id)")
        return objects.first ?? nil
    }
    
}
