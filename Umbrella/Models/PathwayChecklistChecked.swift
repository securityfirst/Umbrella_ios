//
//  PathwayChecklistChecked.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation
import SQLite

class PathwayChecklistChecked: Codable, TableProtocol, Equatable {
    
    // Used in parser from the database to object
    var id: Int
    var languageId: Int
    
    //
    // MARK: - Properties
    var name: String
    var checklistId: Int
    var itemId: Int
    var totalChecked: Int
    var totalItemsChecklist: Int
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.name = ""
        self.checklistId = -1
        self.itemId = -1
        self.totalChecked = -1
        self.totalItemsChecklist = -1
        self.languageId = -1
    }
    
    init(name: String, totalChecked: Int, totalItemsChecklist: Int) {
        self.id = -1
        self.name = name
        self.checklistId = -1
        self.itemId = -1
        self.totalChecked = totalChecked
        self.totalItemsChecklist = totalItemsChecklist
        self.languageId = -1
    }
    
    init(name: String, checklistId: Int, languageId: Int) {
        self.id = -1
        self.name = name
        self.checklistId = checklistId
        self.itemId = 0
        self.totalChecked = 0
        self.totalItemsChecklist = 0
        self.languageId = languageId
    }
    
    init(name: String, checklistId: Int, itemId: Int, totalChecked: Int, totalItemsChecklist: Int) {
        self.id = -1
        self.name = name
        self.checklistId = checklistId
        self.itemId = itemId
        self.totalChecked = totalChecked
        self.totalItemsChecklist = totalItemsChecklist
        self.languageId = -1
    }
    
    init(name: String, checklistId: Int, itemId: Int, totalItemsChecklist: Int) {
        self.id = -1
        self.name = name
        self.checklistId = checklistId
        self.itemId = itemId
        self.totalChecked = 0
        self.totalItemsChecklist = totalItemsChecklist
        self.languageId = -1
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case name = "name"
        case checklistId = "checklist_id"
        case itemId = "item_id"
        case totalChecked = "total_checked"
        case totalItemsChecklist = "total_items_checklist"
        case languageId = "language_id"
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
        
        if container.contains(.checklistId) {
            self.checklistId = try container.decode(Int.self, forKey: .checklistId)
        } else {
            self.checklistId = -1
        }
        
        if container.contains(.itemId) {
            self.itemId = try container.decode(Int.self, forKey: .itemId)
        } else {
            self.itemId = -1
        }
        
        if container.contains(.totalChecked) {
            self.totalChecked = try container.decode(Int.self, forKey: .totalChecked)
        } else {
            self.totalChecked = -1
        }
        
        if container.contains(.totalItemsChecklist) {
            self.totalItemsChecklist = try container.decode(Int.self, forKey: .totalItemsChecklist)
        } else {
            self.totalItemsChecklist = -1
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "pathway_checklist_checked"
    var tableName: String {
        return PathwayChecklistChecked.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "name", type: .string),
            Column(name: "checklist_id", type: .int),
            Column(name: "item_id", type: .int),
            Column(name: "total_items_checklist", type: .int),
            Column(foreignKey: ForeignKey(key: "language_id", table: Table("language"), tableKey: "id"))
        ]
        return array
    }
    
    static func == (lhs: PathwayChecklistChecked, rhs: PathwayChecklistChecked) -> Bool {
        return lhs.checklistId == rhs.checklistId
    }
}
