//
//  CustomChecklistChecked.swift
//  Umbrella
//
//  Created by Lucas Correa on 07/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class CustomChecklistChecked: Codable, TableProtocol, Equatable {
    
    // Used in parser from the database to object
    var id: Int
    
    //
    // MARK: - Properties
    var customChecklistId: Int
    var itemId: Int
    
    //
    // MARK: - Initializers
    
    init() {
        self.id = -1
        self.customChecklistId = -1
        self.itemId = -1
    }
    
    init(customChecklistId: Int, itemId: Int) {
        self.id = -1
        self.customChecklistId = customChecklistId
        self.itemId = itemId
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case customChecklistId = "custom_checklist_id"
        case itemId = "item_id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.customChecklistId) {
            self.customChecklistId = try container.decode(Int.self, forKey: .customChecklistId)
        } else {
            self.customChecklistId = -1
        }
        
        if container.contains(.itemId) {
            self.itemId = try container.decode(Int.self, forKey: .itemId)
        } else {
            self.itemId = -1
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "custom_checklist_checked"
    var tableName: String {
        return CustomChecklistChecked.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "custom_checklist_id", type: .int),
            Column(name: "item_id", type: .int)
        ]
        return array
    }
    
    //
    // MARK: - Equatable
    static func == (lhs: CustomChecklistChecked, rhs: CustomChecklistChecked) -> Bool {
        return lhs.customChecklistId == rhs.customChecklistId && lhs.itemId == rhs.itemId
    }
}
