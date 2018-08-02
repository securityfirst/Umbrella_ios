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
            return ("TextAreaCell", 130.0)
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
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.screenId) {
            self.screenId = try container.decode(Int.self, forKey: .screenId)
        } else {
            self.screenId = -1
        }
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.type) {
            self.type = try container.decode(String.self, forKey: .type)
        } else {
            self.type = ""
        }
        
        if container.contains(.hint) {
            self.hint = try container.decode(String.self, forKey: .hint)
        } else {
            self.hint = ""
        }
        
        if container.contains(.label) {
            self.label = try container.decode(String.self, forKey: .label)
        } else {
            self.label = ""
        }
        
        if container.contains(.options) {
            self.options = try container.decode([OptionItem].self, forKey: .options)
        } else {
            self.options = []
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
