//
//  Screen.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class Screen: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var formId: Int
    
    //
    // MARK: - Properties
    let name: String
    var items: [ItemForm]
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.formId = -1
        self.name = ""
        self.items = []
    }
    
    init(name: String, items: [ItemForm]) {
        self.id = -1
        self.formId = -1
        self.name = name
        self.items = items
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case formId = "form_id"
        case items
        case name = "title"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.formId = try container.decodeIfPresent(Int.self, forKey: .formId) ?? -1
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.items = try container.decodeIfPresent([ItemForm].self, forKey: .items) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(items, forKey: .items)
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "screen"
    var tableName: String {
        return Screen.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "title", type: .string),
            Column(foreignKey: ForeignKey(key: "form_id", table: Table("form"), tableKey: "id"))
        ]
        return array
    }
}
