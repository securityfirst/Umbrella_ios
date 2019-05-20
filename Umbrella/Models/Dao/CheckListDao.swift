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
        return self.sqlProtocol.create(table: CheckList())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [CheckList] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(CheckList.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: CheckList.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: CheckList) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(CheckList.table) ('index', 'category_id') VALUES (\(object.index ?? -1), \(object.categoryId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// Get Checklist
    ///
    /// - Returns: CheckList
    func getChecklist(id: Int) -> CheckList? {
        let objects: [CheckList?] = self.sqlProtocol.select(withQuery: "SELECT * FROM \(CheckList.table) WHERE id = \(id)")
        return objects.first ?? nil
    }
}
