//
//  CustomChecklist.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class CustomChecklist: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var languageId: Int
    var name: String!
    
    //
    // MARK: - Properties
    var items: [CustomCheckItem]
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.languageId = -1
        self.name = ""
        self.items = []
    }
    
    init(name: String) {
        self.id = -1
        self.languageId = -1
        self.name = name
        self.items = []
    }
    
    init(name: String, languageId: Int) {
        self.id = -1
        self.languageId = languageId
        self.name = name
        self.items = []
    }
    
    init(name: String, items: [CustomCheckItem]) {
        self.id = -1
        self.languageId = -1
        self.name = name
        self.items = items
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case languageId = "language_id"
        case name
        case items = "list"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.languageId) {
            self.languageId = try container.decode(Int.self, forKey: .languageId)
        } else {
            self.languageId = -1
        }
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.items) {
            self.items = try container.decode([CustomCheckItem].self, forKey: .items)
        } else {
            self.items = []
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "custom_checklist"
    var tableName: String {
        return CustomChecklist.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "name", type: .string),
            Column(foreignKey: ForeignKey(key: "language_id", table: Table("language"), tableKey: "id"))
        ]
        return array
    }
}
