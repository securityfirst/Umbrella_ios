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
        return self.sqlProtocol.create(table: Category())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [Category] {
        return self.sqlProtocol.select(withQuery: "SELECT id, name as title, description, icon, [index], folder_name, deeplink, language_id, parent, template FROM \(Category.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: Category.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: Category) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(Category.table) ('name', 'description', 'icon', 'index', 'folder_name', 'deeplink', 'parent', 'language_id', 'template') VALUES (\"\(object.name ?? "")\", \"\(object.description ?? "")\", \"\(object.icon ?? "")\", \(object.index ?? -1), '\(object.folderName ?? "")', '\(object.deeplink ?? "")', \(object.parent), \(object.languageId), '\(object.template)')")
        return rowId
    }
    
    //
    // MARK: - Custom functions
}
