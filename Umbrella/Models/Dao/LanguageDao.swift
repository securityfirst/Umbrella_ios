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
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return SQLManager.shared.create(table: Language())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Language] {
        return SQLManager.shared.select(withQuery: "SELECT * FROM \(Language.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return SQLManager.shared.drop(tableName: Language.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Language) -> Int64 {
        let rowId = SQLManager.shared.insert(withQuery: "INSERT INTO \(Language.table) ('name') VALUES (\"\(object.name )\")")
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
}
