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
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.formId) {
            self.formId = try container.decode(Int.self, forKey: .formId)
        } else {
            self.formId = -1
        }
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.items) {
            self.items = try container.decode([ItemForm].self, forKey: .items)
        } else {
            self.items = []
        }
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
            Column(name: "name", type: .string),
            Column(foreignKey: ForeignKey(key: "form_id", table: Table("form"), tableKey: "id"))
        ]
        return array
    }
}
