//
//  CheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class CheckItem: Codable, TableProtocol, NSCopying {
    
    // Used in parser from the database to object
    var id: Int
    var checkListId: Int
    
    //
    // MARK: - Properties
    
    //Name and label are same information (the title of checkbox), so a label is used to when the checkbox is checked and as I need to save the name, I create the attribute label only to get data.
    var name: String
    private var label: String
    var isLabel: Bool = false
    var checked: Bool = false
    var answer: Int
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.checkListId = -1
        self.name = ""
        self.label = ""
        self.isLabel = false
        self.answer = 0
    }
    
    init(name: String) {
        self.id = -1
        self.checkListId = -1
        self.name = name
        self.label = ""
        self.isLabel = false
        self.answer = 0
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case checkListId = "checklist_id"
        case name = "check"
        case label = "label"
        case isLabel = "is_label"
        case answer
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.checkListId = try container.decodeIfPresent(Int.self, forKey: .checkListId) ?? -1
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        
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
        
        self.answer = try container.decodeIfPresent(Int.self, forKey: .answer) ?? 0
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if name.count > 0 && !isLabel {
            try container.encode(name, forKey: .name)
        }
        
        if isLabel {
            try container.encode(name, forKey: .label)
        }
        
        try container.encode(answer, forKey: .answer)
    }
    
    //
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = CheckItem()
        copy.id = self.id
        copy.checkListId = self.checkListId
        copy.name = self.name
        copy.label = self.label
        copy.isLabel = self.isLabel
        copy.checked = self.checked
        return copy
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
            Column(foreignKey: ForeignKey(key: "checklist_id", table: Table(CheckList.table), tableKey: "id"))
        ]
        return array
    }
}
