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
    var createdAt: String
    var isMatrix: Int
    var userMatrix: String
    
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
        self.createdAt = ""
        self.isMatrix = -1
        self.userMatrix = ""
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
        self.createdAt = ""
        self.isMatrix = -1
        self.userMatrix = ""
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
        self.createdAt = ""
        self.isMatrix = -1
        self.userMatrix = ""
    }
    
    init(subCategoryName: String, subCategoryId: Int, difficultyId: Int, checklistId: Int, itemId: Int, totalItemsChecklist: Int, isMatrix: Int, userMatrix: String) {
        self.id = -1
        self.subCategoryName = subCategoryName
        self.subCategoryId = subCategoryId
        self.difficultyId = difficultyId
        self.checklistId = checklistId
        self.itemId = itemId
        self.totalChecked = -1
        self.totalItemsChecklist = totalItemsChecklist
        self.languageId = -1
        
        let dateFormatter = Global.dateFormatter
        dateFormatter.dateFormat = "dd/MM/YYYY hh:mm a"
        let date = dateFormatter.string(from: Date())
        self.createdAt = date
        self.isMatrix = isMatrix
        self.userMatrix = userMatrix
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
        self.createdAt = ""
        self.isMatrix = -1
        self.userMatrix = ""
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
        self.createdAt = ""
        self.isMatrix = -1
        self.userMatrix = ""
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
        case createdAt = "created_at"
        case isMatrix = "is_matrix"
        case userMatrix = "user_matrix"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.languageId = try container.decodeIfPresent(Int.self, forKey: .languageId) ?? -1
        self.subCategoryName = try container.decodeIfPresent(String.self, forKey: .subCategoryName) ?? ""
        self.subCategoryId = try container.decodeIfPresent(Int.self, forKey: .subCategoryId) ?? -1
        self.difficultyId = try container.decodeIfPresent(Int.self, forKey: .difficultyId) ?? -1
        self.checklistId = try container.decodeIfPresent(Int.self, forKey: .checklistId) ?? -1
        self.itemId = try container.decodeIfPresent(Int.self, forKey: .itemId) ?? -1
        self.totalChecked = try container.decodeIfPresent(Int.self, forKey: .totalChecked) ?? -1
        self.totalItemsChecklist = try container.decodeIfPresent(Int.self, forKey: .totalItemsChecklist) ?? -1
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.isMatrix = try container.decodeIfPresent(Int.self, forKey: .isMatrix) ?? -1
        self.userMatrix = try container.decodeIfPresent(String.self, forKey: .userMatrix) ?? ""
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
            Column(name: "created_at", type: .string),
            Column(name: "is_matrix", type: .int),
            Column(name: "user_matrix", type: .string),
            Column(foreignKey: ForeignKey(key: "language_id", table: Table("language"), tableKey: "id"))
        ]
        return array
    }
    
    static func == (lhs: ChecklistChecked, rhs: ChecklistChecked) -> Bool {
        return lhs.subCategoryId == rhs.subCategoryId && lhs.checklistId == rhs.checklistId
    }
}
