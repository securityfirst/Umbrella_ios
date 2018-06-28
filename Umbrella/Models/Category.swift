//
//  Category.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class Category: Codable, TableProtocol, FolderProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var languageId: Int
    
    //
    // MARK: - Properties
    var name: String?
    let index: Float?
    var parent: Int
    var folderName: String?
    var categories: [Category]
    var segments: [Segment]
    var checkList: [CheckList]
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.parent = 0
        self.languageId = -1
        
        self.name = ""
        self.index = 0
        self.folderName = ""
        self.categories = []
        self.segments = []
        self.checkList = []
    }
    
    init(name: String, index: Float, folderName: String = "") {
        self.id = -1
        self.parent = 0
        self.languageId = -1
        
        self.name = name
        self.index = index
        self.folderName = folderName
        self.categories = []
        self.segments = []
        self.checkList = []
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case parent
        case languageId = "language_id"
        case name = "title"
        case index
        case folderName = "folder_name"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.parent) {
            self.parent = try container.decode(Int.self, forKey: .parent)
        } else {
            self.parent = 0
        }
        
        if container.contains(.languageId) {
            self.languageId = try container.decode(Int.self, forKey: .languageId)
        } else {
            self.languageId = -1
        }
        
        if container.contains(.index) {
            self.index = try container.decode(Float.self, forKey: .index)
        } else {            
            self.index = 0
        }
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.folderName) {
            self.folderName = try container.decode(String.self, forKey: .folderName)
        } else {
            self.folderName = ""
        }
        
        self.categories = []
        self.segments = []
        self.checkList = []
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "category"
    var tableName: String {
        return Category.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "name", type: .string),
            Column(name: "index", type: .real),
            Column(name: "folder_name", type: .string),
            Column(name: "parent", type: .int),
            Column(foreignKey: ForeignKey(key: "language_id", table: Table("language"), tableKey: "id"))
        ]
        return array
    }
}
