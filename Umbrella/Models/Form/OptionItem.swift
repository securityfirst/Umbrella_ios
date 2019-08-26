//
//  OptionItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class OptionItem: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var itemFormId: Int
    
    //
    // MARK: - Properties
    let label: String
    let value: String
    var answer: Int
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.itemFormId = -1
        self.label = ""
        self.value = ""
        self.answer = 0
    }
    
    init(label: String, value: String) {
        self.id = -1
        self.itemFormId = -1
        self.label = label
        self.value = value
        self.answer = 0
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case itemFormId = "item_form_id"
        case label
        case value
        case answer
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.itemFormId = try container.decodeIfPresent(Int.self, forKey: .itemFormId) ?? -1
        self.label = try container.decodeIfPresent(String.self, forKey: .label) ?? ""
        self.value = try container.decodeIfPresent(String.self, forKey: .value) ?? ""
        self.answer = try container.decodeIfPresent(Int.self, forKey: .answer) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(value, forKey: .value)
        try container.encode(label, forKey: .label)
        try container.encode(answer, forKey: .answer)
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "option_item"
    var tableName: String {
        return OptionItem.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "label", type: .string),
            Column(name: "value", type: .real),
            Column(foreignKey: ForeignKey(key: "item_form_id", table: Table("item_form"), tableKey: "id"))
        ]
        return array
    }
}
