//
//  LanguageDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 25/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct LanguageDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: Language())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Language] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(Language.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: Language.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Language) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(Language.table) ('name') VALUES (\"\(object.name )\")")
        return rowId
    }
    
    /// Reset connection
    ///
    func resetConnection() {
        self.sqlProtocol.resetConnection()
    }
    
    //
    // MARK: - Custom functions
    
}
