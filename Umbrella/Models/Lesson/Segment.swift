//
//  Segment.swift
//  Umbrella
//
//  Created by Lucas Correa on 06/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class Segment: Codable, TableProtocol, NSCopying, ModelProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var categoryId: Int
    
    //
    // MARK: - Properties
    var name: String?
    var file: String?
    var index: Float?
    var content: String?
    var favourite: Bool = false
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.categoryId = -1
        self.name = ""
        self.file = ""
        self.index = 0
        self.content = ""
        self.favourite = false
    }
    
    init(name: String, index: Float, content: String) {
        self.id = -1
        self.categoryId = -1
        self.name = name
        self.file = ""
        self.index = index
        self.content = content
        self.favourite = false
    }

    init(name: String, file: String, index: Float, content: String) {
        self.id = -1
        self.categoryId = -1
        self.name = name
        self.file = file
        self.index = index
        self.content = content
        self.favourite = false
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case name = "title"
        case file
        case index
        case content
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
        
        if container.contains(.file) {
            self.file = try container.decode(String.self, forKey: .file)
        } else {
            self.file = ""
        }
        
        if container.contains(.index) {
            self.index = try container.decode(Float.self, forKey: .index)
        } else {
            self.index = 0
        }
        
        if container.contains(.content) {
            self.content = try container.decode(String.self, forKey: .content).fromBase64()
        } else {
            self.content = ""
        }
    }
    
    //
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Segment()
        copy.id = self.id
        copy.categoryId = self.categoryId
        copy.name = self.name
        copy.file = self.file
        copy.index = self.index
        copy.content = self.content
        copy.favourite = self.favourite
        return copy
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
            Column(name: "file", type: .string),
            Column(name: "content", type: .string),
            Column(foreignKey: ForeignKey(key: "category_id", table: Table("category"), tableKey: "id"))
        ]
        return array
    }
}
