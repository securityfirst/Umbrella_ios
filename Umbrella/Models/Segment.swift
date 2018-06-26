//
//  Segment.swift
//  Umbrella
//
//  Created by Lucas Correa on 06/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class Segment: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var categoryId: Int
    
    //
    // MARK: - Properties
    let name: String?
    let index: Float?
    var content: String?
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.categoryId = -1
        self.name = ""
        self.index = 0
        self.content = ""
    }
    
    init(name: String, index: Float, content: String) {
        self.id = -1
        self.categoryId = -1
        self.name = name
        self.index = index
        self.content = content
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId
        case name = "title"
        case index
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.categoryId) {
            self.categoryId = try container.decode(Int.self, forKey: .categoryId)
        } else {
            self.categoryId = -1
        }
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.index) {
            self.index = try container.decode(Float.self, forKey: .index)
        } else {
            self.index = 0
        }
        
       self.content = ""
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "segment"
    var tableName: String {
        return Segment.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "name", type: .string),
            Column(name: "index", type: .real),
            Column(name: "content", type: .string),
            Column(foreignKey: ForeignKey(key: "category_id", table: Table("category"), tableKey: "id"))
        ]
        return array
    }
}
