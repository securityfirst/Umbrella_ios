//
//  CategoryDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct CategoryDao: DaoProtocol {
    
    func createTable() -> Bool {
        return SQLManager.shared.create(table: Category())
    }
    
    func list() -> [Category] {
     return [Category]()
    }
    
    func dropTable() -> Bool {
        return SQLManager.shared.drop(tableName: "category")
    }
    
    func insert(_ object: Category) -> Bool {
        let success = SQLManager.shared.insert(withQuery: "INSERT INTO category ('category', 'difficultyAdvanced', 'difficultyBeginner', 'difficultyExpert', 'hasDifficulty', 'parent', 'textAdvanced', 'textBeginner', 'textExpert') VALUES ('\(object.name ?? "")', 0, 0, 0, 0, 0, 'Teste 1', 'Teste 2', 'Teste 3')")
        return success
    }
}
