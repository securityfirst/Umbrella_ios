//
//  FormAnswer.swift
//  Umbrella
//
//  Created by Lucas Correa on 31/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class FormAnswer: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var formAnswerId: Int
    var formId: Int
    var itemFormId: Int
    var optionItemId: Int
    var createdAt: String
    
    //
    // MARK: - Properties
    var text: String
    var choice: Int
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.formAnswerId = -1
        self.formId = -1
        self.itemFormId = -1
        self.optionItemId = -1
        self.text = ""
        self.choice = -1
        self.createdAt = ""
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case formAnswerId = "form_answer_id"
        case formId = "form_id"
        case itemFormId = "item_form_id"
        case optionItemId = "option_item_id"
        case text
        case choice
        case createdAt = "created_at"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.formAnswerId) {
            self.formAnswerId = try container.decode(Int.self, forKey: .formAnswerId)
        } else {
            self.formAnswerId = -1
        }
        
        if container.contains(.formId) {
            self.formId = try container.decode(Int.self, forKey: .formId)
        } else {
            self.formId = -1
        }
        
        if container.contains(.itemFormId) {
            self.itemFormId = try container.decode(Int.self, forKey: .itemFormId)
        } else {
            self.itemFormId = -1
        }
        
        if container.contains(.optionItemId) {
            self.optionItemId = try container.decode(Int.self, forKey: .optionItemId)
        } else {
            self.optionItemId = -1
        }
        
        if container.contains(.text) {
            self.text = try container.decode(String.self, forKey: .text)
        } else {
            self.text = ""
        }
        
        if container.contains(.choice) {
            self.choice = try container.decode(Int.self, forKey: .choice)
        } else {
            self.choice = -1
        }
        
        if container.contains(.createdAt) {
            self.createdAt = try container.decode(String.self, forKey: .createdAt)
        } else {
            self.createdAt = ""
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "form_answer"
    var tableName: String {
        return FormAnswer.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "form_answer_id", type: .int),
            Column(name: "text", type: .string, isNotNull: false),
            Column(name: "choice", type: .int, isNotNull: false),
            Column(name: "created_at", type: .string),
            Column(name: "form_id", type: .int),
            Column(name: "item_form_id", type: .int, isNotNull: false),
            Column(name: "option_item_id", type: .int, isNotNull: false)
//            Column(foreignKey: ForeignKey(key: "form_id", table: Table("form"), tableKey: "id")),
//            Column(foreignKey: ForeignKey(key: "item_id", table: Table("item_form"), tableKey: "id")),
//            Column(foreignKey: ForeignKey(key: "option_id", table: Table("option_item"), tableKey: "id"))
            
        ]
        return array
    }
}
