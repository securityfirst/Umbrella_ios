//
//  CheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class CheckList: Codable, TableProtocol, NSCopying, ModelProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var name: String?
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
        self.name = ""
        self.categoryId = -1
        self.index = 0
        self.items = []
        self.favourite = false
    }
    
    init(name: String, index: Float, items: [CheckItem]) {
        self.id = -1
        self.name = ""
        self.categoryId = -1
        self.index = index
        self.items = items
        self.favourite = false
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case categoryId = "category_id"
        case index
        case items = "list"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId) ?? -1
        self.index = try container.decodeIfPresent(Float.self, forKey: .index) ?? 0
        self.items = try container.decodeIfPresent([CheckItem].self, forKey: .items) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(index, forKey: .index)
        try container.encode(items, forKey: .items)
    }
    
    //
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = CheckList()
        copy.id = self.id
        copy.name = self.name
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
            Column(name: "name", type: .string),
            Column(name: "index", type: .real),
            Column(foreignKey: ForeignKey(key: "category_id", table: Table("category"), tableKey: "id"))
        ]
        return array
    }
}
