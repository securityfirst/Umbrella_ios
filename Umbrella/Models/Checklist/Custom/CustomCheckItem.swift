//
//  CustomCheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class CustomCheckItem: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var customChecklistId: Int
    
    //
    // MARK: - Properties
    var name: String
    var checked: Bool = false
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.customChecklistId = -1
        self.name = ""
    }
    
    init(name: String) {
        self.id = -1
        self.customChecklistId = -1
        self.name = name
    }
    
    init(name: String, checklistId: Int) {
        self.id = -1
        self.customChecklistId = checklistId
        self.name = name
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case customChecklistId = "custom_checklist_id"
        case name = "name"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.customChecklistId) {
            self.customChecklistId = try container.decode(Int.self, forKey: .customChecklistId)
        } else {
            self.customChecklistId = -1
        }
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "custom_check_item"
    var tableName: String {
        return CustomCheckItem.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "name", type: .string),
            Column(foreignKey: ForeignKey(key: "custom_checklist_id", table: Table(CustomChecklist.table), tableKey: "id"))
        ]
        return array
    }
}
