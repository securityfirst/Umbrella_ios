//
//  CategoryDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct CategoryDao: DaoProtocol {
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return SQLManager.shared.create(table: Category())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Category] {
        return [Category]()
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return SQLManager.shared.drop(tableName: Category.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Category) -> Int64 {
        let rowId = SQLManager.shared.insert(withQuery: "INSERT INTO \(Category.table) ('name', 'index', 'folder_name', 'parent', 'language_id') VALUES (\"\(object.name ?? "")\", \(object.index ?? -1), '\(object.folderName ?? "")', \(object.parent), \(object.languageId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
