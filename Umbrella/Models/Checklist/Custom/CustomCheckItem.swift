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
    var answer: Int
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.customChecklistId = -1
        self.name = ""
        self.answer = 0
    }
    
    init(name: String) {
        self.id = -1
        self.customChecklistId = -1
        self.name = name
        self.answer = 0
    }
    
    init(name: String, checklistId: Int) {
        self.id = -1
        self.customChecklistId = checklistId
        self.name = name
        self.answer = 0
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case customChecklistId = "custom_checklist_id"
        case name = "check"
        case answer
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.customChecklistId = try container.decodeIfPresent(Int.self, forKey: .customChecklistId) ?? -1
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.answer = try container.decodeIfPresent(Int.self, forKey: .answer) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(answer, forKey: .answer)
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
