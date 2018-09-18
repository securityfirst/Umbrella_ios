//
//  DifficultyRule.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class DifficultyRule: Codable, TableProtocol {
    
    //
    // MARK: - Properties
    var categoryId: Int
    var difficultyId: Int
    
    //
    // MARK: - Initializers
    init() {
        self.categoryId = -1
        self.difficultyId = -1
    }
    
    init(categoryId: Int, difficultyId: Int) {
        self.categoryId = categoryId
        self.difficultyId = difficultyId
    }
    
    init(categoryId: Int) {
        self.categoryId = categoryId
        self.difficultyId = -1
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case difficultyId = "difficulty_id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.categoryId) {
            self.categoryId = try container.decode(Int.self, forKey: .categoryId)
        } else {
            self.categoryId = -1
        }
        
        if container.contains(.difficultyId) {
            self.difficultyId = try container.decode(Int.self, forKey: .difficultyId)
        } else {
            self.difficultyId = -1
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "difficulty_rule"
    var tableName: String {
        return DifficultyRule.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "category_id", type: .int),
            Column(name: "difficulty_id", type: .int)
        ]
        return array
    }
}
