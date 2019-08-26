//
//  ItemForm.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

enum FormType {
    case textInput
    case textArea
    case multiChoice
    case singleChoice
    case label
    case none
    
    func values() -> (identifierCell: String, sizeOfCell: CGFloat) {
        
        switch self {
        case .textInput:
            return ("TextFieldCell", 65.0)
        case .textArea:
            return ("TextAreaCell", 140.0)
        case .multiChoice:
            return ("MultiChoiceCell", 50.0)
        case .singleChoice:
            return ("SingleChoiceCell", 50.0)
        case .label:
            return ("LabelCell", 50.0)
        case .none:
            return ("LabelCell", 50.0)
        }
    }
}

class ItemForm: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var screenId: Int
    
    //
    // MARK: - Properties
    let name: String
    let type: String
    let label: String
    let hint: String
    var options: [OptionItem]
    var answer: String
    
    var formType: FormType {
        switch type {
        case "text_input":
            return .textInput
        case "text_area":
            return .textArea
        case "multiple_choice":
            return .multiChoice
        case "single_choice":
            return .singleChoice
        case "label":
            return .label
        default:
            return .none
        }
    }
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.screenId = -1
        self.name = ""
        self.type = ""
        self.label = ""
        self.hint = ""
        self.answer = ""
        self.options = []
    }
    
    init(name: String, type: String, label: String, hint: String, options: [OptionItem]) {
        self.id = -1
        self.screenId = -1
        self.name = name
        self.type = type
        self.label = label
        self.hint = hint
        self.options = options
        self.answer = ""
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case screenId = "screen_id"
        case name
        case type
        case label
        case hint
        case options
        case answer
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.screenId = try container.decodeIfPresent(Int.self, forKey: .screenId) ?? -1
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        self.hint = try container.decodeIfPresent(String.self, forKey: .hint) ?? ""
        self.label = try container.decodeIfPresent(String.self, forKey: .label) ?? ""
        self.options = try container.decodeIfPresent([OptionItem].self, forKey: .options) ?? []
        self.answer = try container.decodeIfPresent(String.self, forKey: .answer) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(label, forKey: .label)
        try container.encode(answer, forKey: .answer)
        
        if hint.count > 0 {
            try container.encode(hint, forKey: .hint)
        }
        
        if options.count > 0 {
            try container.encode(options, forKey: .options)
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "item_form"
    var tableName: String {
        return ItemForm.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "name", type: .string),
            Column(name: "type", type: .string),
            Column(name: "label", type: .string),
            Column(name: "hint", type: .string),
            Column(foreignKey: ForeignKey(key: "screen_id", table: Table("screen"), tableKey: "id"))
        ]
        return array
    }
}
