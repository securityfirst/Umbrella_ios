//
//  FormAnswer.swift
//  Umbrella
//
//  Created by Lucas Correa on 31/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class FormAnswer: Codable, TableProtocol, Equatable {
    
    // Used in parser from the database to object
    var id: Int
    var formAnswerId: Int
    var formId: Int
    var itemFormId: Int
    var optionItemId: Int
    var createdAt: String
    var isMatrix: Int
    var userMatrix: String
    
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
        self.isMatrix = -1
        self.userMatrix = ""
    }
    
    init(formAnswerId: Int, formId: Int, itemFormId: Int, optionItemId: Int, text: String, choice: Int) {
        self.id = -1
        self.formAnswerId = formAnswerId
        self.formId = formId
        self.itemFormId = itemFormId
        self.optionItemId = optionItemId
        self.text = text
        self.choice = choice
        
        let dateFormatter = Global.dateFormatter
        dateFormatter.dateFormat = "MM/dd/YYYY HH:mm a"
        let date = dateFormatter.string(from: Date())
        self.createdAt = date
        self.isMatrix = 0
        self.userMatrix = ""
    }
    
    init(formAnswerId: Int, formId: Int, itemFormId: Int, optionItemId: Int, text: String, choice: Int, isMatrix: Int, userMatrix: String) {
        self.id = -1
        self.formAnswerId = formAnswerId
        self.formId = formId
        self.itemFormId = itemFormId
        self.optionItemId = optionItemId
        self.text = text
        self.choice = choice
        
        let dateFormatter = Global.dateFormatter
        dateFormatter.dateFormat = "MM/dd/YYYY HH:mm a"
        let date = dateFormatter.string(from: Date())
        self.createdAt = date
        self.isMatrix = isMatrix
        self.userMatrix = userMatrix
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
        case isMatrix = "is_matrix"
        case userMatrix = "user_matrix"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.formAnswerId = try container.decodeIfPresent(Int.self, forKey: .formAnswerId) ?? -1
        self.formId = try container.decodeIfPresent(Int.self, forKey: .formId) ?? -1
        self.itemFormId = try container.decodeIfPresent(Int.self, forKey: .itemFormId) ?? -1
        self.optionItemId = try container.decodeIfPresent(Int.self, forKey: .optionItemId) ?? -1
        self.text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        self.choice = try container.decodeIfPresent(Int.self, forKey: .choice) ?? -1
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt) ?? ""
        self.isMatrix = try container.decodeIfPresent(Int.self, forKey: .isMatrix) ?? -1
        self.userMatrix = try container.decodeIfPresent(String.self, forKey: .userMatrix) ?? ""
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
            Column(name: "option_item_id", type: .int, isNotNull: false),
            Column(name: "is_matrix", type: .int),
            Column(name: "user_matrix", type: .string)
        ]
        return array
    }
    
    static func == (lhs: FormAnswer, rhs: FormAnswer) -> Bool {
        return lhs.formId == rhs.formId && lhs.formAnswerId == rhs.formAnswerId
    }
}
