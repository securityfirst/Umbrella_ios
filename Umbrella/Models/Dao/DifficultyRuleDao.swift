//
//  DifficultyRuleDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct DifficultyRuleDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: DifficultyRule())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [DifficultyRule] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(DifficultyRule.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: DifficultyRule.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: DifficultyRule) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(DifficultyRule.table) ('category_id', 'difficulty_id') VALUES (\(object.categoryId) , \(object.difficultyId) )")
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// Check if there is rule to a difficulty
    ///
    /// - Parameter difficultyRule: DifficultyRule
    /// - Returns: Int
    func isExistRule(to difficultyRule: DifficultyRule) -> Int {
        let result = self.sqlProtocol.select(withQuery: "SELECT * FROM \(DifficultyRule.table) WHERE category_id = \(difficultyRule.categoryId) ")
        
        var difficultyRule = -1
        let rule = result.first
        
        if let rule = rule {
            difficultyRule = Int((rule["difficulty_id"] as? Int64)!)
        }
        
        return difficultyRule
    }
    
    /// Delete all formAnswer to formAnswerId in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func remove(_ categoryId: Int) -> Bool {
        let sql = "DELETE FROM \(DifficultyRule.table) WHERE category_id = \(categoryId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
}
