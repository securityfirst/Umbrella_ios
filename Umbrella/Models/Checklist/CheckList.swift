//
//  CheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class CheckList: Codable, TableProtocol, NSCopying {
    
    // Used in parser from the database to object
    var id: Int
    var categoryId: Int
    
    //
    // MARK: - Properties
    var index: Float?
    var items: [CheckItem]
    var favourite: Bool = false
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.categoryId = -1
        self.index = 0
        self.items = []
        self.favourite = false
    }
    
    init(index: Float, items: [CheckItem]) {
        self.id = -1
        self.categoryId = -1
        self.index = index
        self.items = items
        self.favourite = false
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case index
        case items = "list"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.categoryId) {
            self.categoryId = try container.decode(Int.self, forKey: .categoryId)
        } else {
            self.categoryId = -1
        }
        
        if container.contains(.index) {
            self.index = try container.decode(Float.self, forKey: .index)
        } else {
            self.index = 0
        }
        
        if container.contains(.items) {
            self.items = try container.decode([CheckItem].self, forKey: .items)
        } else {
            self.items = []
        }
    }
    
    //
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = CheckList()
        copy.id = self.id
        copy.categoryId = self.categoryId
        copy.index = self.index
        copy.favourite = self.favourite
        return copy
    }
    
    /// Count just item Check different of Label
    ///
    /// - Returns: Int
    func countItemCheck() -> Int {
        // Remove Label Item
        return items.filter { $0.isLabel == false }.count
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "checklist"
    var tableName: String {
        return CheckList.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "index", type: .real),
            Column(foreignKey: ForeignKey(key: "category_id", table: Table("category"), tableKey: "id"))
        ]
        return array
    }
}
