//
//  CheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class CheckItem: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var checkListId: Int
    
    //
    // MARK: - Properties
    
    //Name and label are same information (the title of checkbox), so a label is used to when the checkbox is checked and as I need to save the name, I create the attribute label only to get data.
    var name: String
    private let label: String
    var isLabel: Bool = false
    var checked: Bool = false
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.checkListId = -1
        self.name = ""
        self.label = ""
        self.isLabel = false
    }
    
    init(name: String) {
        self.id = -1
        self.checkListId = -1
        self.name = name
        self.label = ""
        self.isLabel = false
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case checkListId = "check_list_id"
        case name = "check"
        case label = "label"
        case isLabel = "is_label"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.checkListId) {
            self.checkListId = try container.decode(Int.self, forKey: .checkListId)
        } else {
            self.checkListId = -1
        }
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        // This attribute is used when it is decoding from the database
        if container.contains(.isLabel) {
            self.isLabel = try container.decode(Int.self, forKey: .isLabel) == 1
        } else {
            self.isLabel = false
        }
        
        if container.contains(.label) {
            // Get the title of tag ".label"
            self.name = try container.decode(String.self, forKey: .label)
            self.label = try container.decode(String.self, forKey: .label)
            self.isLabel = true
        } else {
            self.label = ""
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "check_item"
    var tableName: String {
        return CheckItem.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "name", type: .string),
            Column(name: "is_label", type: .int),
            Column(foreignKey: ForeignKey(key: "check_list_id", table: Table(CheckList.table), tableKey: "id"))
        ]
        return array
    }
}
