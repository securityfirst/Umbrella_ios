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
        return self.sqlProtocol.create(table: Form())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Form] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(Form.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: Form.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Form) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(Form.table) ('title', 'language_id') VALUES (\"\(object.name)\", \(object.languageId) )")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
