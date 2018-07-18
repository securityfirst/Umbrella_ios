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
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.itemFormId = -1
        self.label = ""
        self.value = ""
    }
    
    init(label: String, value: String) {
        self.id = -1
        self.itemFormId = -1
        self.label = label
        self.value = value
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case itemFormId = "item_form_id"
        case label
        case value
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.itemFormId) {
            self.itemFormId = try container.decode(Int.self, forKey: .itemFormId)
        } else {
            self.itemFormId = -1
        }
        
        if container.contains(.label) {
            self.label = try container.decode(String.self, forKey: .label)
        } else {
            self.label = ""
        }
        
        if container.contains(.value) {
            self.value = try container.decode(String.self, forKey: .value)
        } else {
            self.value = ""
        }
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
