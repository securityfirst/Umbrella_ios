//
//  ChecklistChecked.swift
//  Umbrella
//
//  Created by Lucas Correa on 26/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class ChecklistChecked: Codable, TableProtocol, Equatable {
    
    // Used in parser from the database to object
    var id: Int
    //   attributes: subcategory_name,  subcategory_id, difficulty_id, checklist_id, item_id, total_items_checklist
    var languageId: Int
    
    //
    // MARK: - Properties
    var subCategoryName: String
    var subCategoryId: Int
    var difficultyId: Int
    var checklistId: Int
    var itemId: Int
    var totalChecked: Int
    var totalItemsChecklist: Int
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.subCategoryName = ""
        self.subCategoryId = -1
        self.difficultyId = -1
        self.checklistId = -1
        self.itemId = -1
        self.totalChecked = -1
        self.totalItemsChecklist = -1
        self.languageId = -1
    }
    
    init(subCategoryName: String, totalChecked: Int, totalItemsChecklist: Int) {
        self.id = -1
        self.subCategoryName = subCategoryName
        self.subCategoryId = -1
        self.difficultyId = -1
        self.checklistId = -1
        self.itemId = -1
        self.totalChecked = totalChecked
        self.totalItemsChecklist = totalItemsChecklist
        self.languageId = -1
    }
    
    init(subCategoryName: String, subCategoryId: Int, difficultyId: Int, checklistId: Int, itemId: Int, totalItemsChecklist: Int) {
        self.id = -1
        self.subCategoryName = subCategoryName
        self.subCategoryId = subCategoryId
        self.difficultyId = difficultyId
        self.checklistId = checklistId
        self.itemId = itemId
        self.totalChecked = -1
        self.totalItemsChecklist = totalItemsChecklist
        self.languageId = -1
    }
    
    init(subCategoryName: String, subCategoryId: Int, difficultyId: Int, checklistId: Int, languageId: Int) {
        self.id = -1
        self.subCategoryName = subCategoryName
        self.subCategoryId = subCategoryId
        self.difficultyId = difficultyId
        self.checklistId = checklistId
        self.itemId = 0
        self.totalChecked = 0
        self.totalItemsChecklist = 0
        self.languageId = languageId
    }
    
    init(subCategoryName: String, subCategoryId: Int, difficultyId: Int, checklistId: Int, itemId: Int, totalChecked: Int, totalItemsChecklist: Int) {
        self.id = -1
        self.subCategoryName = subCategoryName
        self.subCategoryId = subCategoryId
        self.difficultyId = difficultyId
        self.checklistId = checklistId
        self.itemId = itemId
        self.totalChecked = totalChecked
        self.totalItemsChecklist = totalItemsChecklist
        self.languageId = -1
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case subCategoryName = "subcategory_name"
        case subCategoryId = "subcategory_id"
        case difficultyId = "difficulty_id"
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
        
        if container.contains(.subCategoryName) {
            self.subCategoryName = try container.decode(String.self, forKey: .subCategoryName)
        } else {
            self.subCategoryName = ""
        }
        
        if container.contains(.subCategoryId) {
            self.subCategoryId = try container.decode(Int.self, forKey: .subCategoryId)
        } else {
            self.subCategoryId = -1
        }
        
        if container.contains(.difficultyId) {
            self.difficultyId = try container.decode(Int.self, forKey: .difficultyId)
        } else {
            self.difficultyId = -1
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
    static var table: String = "checklist_checked"
    var tableName: String {
        return ChecklistChecked.table
    }

    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "subcategory_name", type: .string),
            Column(name: "subcategory_id", type: .int),
            Column(name: "difficulty_id", type: .int),
            Column(name: "checklist_id", type: .int),
            Column(name: "item_id", type: .int),
            Column(name: "total_items_checklist", type: .int),
            Column(foreignKey: ForeignKey(key: "language_id", table: Table("language"), tableKey: "id"))
        ]
        return array
    }
    
    static func == (lhs: ChecklistChecked, rhs: ChecklistChecked) -> Bool {
        return lhs.subCategoryId == rhs.subCategoryId && lhs.checklistId == rhs.checklistId
    }
}
