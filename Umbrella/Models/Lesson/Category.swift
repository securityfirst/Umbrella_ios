//
//  Category.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

enum Template : String {
    case glossary
}

class Category: Codable, TableProtocol, FolderProtocol, NSCopying, Hashable {
    
    // Used in parser from the database to object
    var id: Int
    var languageId: Int
    
    //
    // MARK: - Properties
    var name: String?
    var description: String?
    var icon: String?
    var index: Float?
    var parent: Int
    var template: String
    var folderName: String?
    var categories: [Category]
    var segments: [Segment]
    var checkLists: [CheckList]
    
    var hashValue: Int {
        return id.hashValue
    }
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.parent = 0
        self.languageId = -1
        self.template = ""
        self.name = ""
        self.description = ""
        self.icon = ""
        self.index = 0
        self.folderName = ""
        self.categories = []
        self.segments = []
        self.checkLists = []
    }
    
    init(name: String, description: String, icon: String = "", index: Float, folderName: String = "") {
        self.id = -1
        self.parent = 0
        self.languageId = -1
        self.template = ""
        self.name = name
        self.description = description
        self.icon = icon
        self.index = index
        self.folderName = folderName
        self.categories = []
        self.segments = []
        self.checkLists = []
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case parent
        case languageId = "language_id"
        case name = "title"
        case template
        case description
        case icon
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
        
        if container.contains(.template) {
            self.template = try container.decode(String.self, forKey: .template)
        } else {
            self.template = ""
        }
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.description) {
            self.description = try container.decode(String.self, forKey: .description)
        } else {
            self.description = ""
        }
        
        if container.contains(.icon) {
            self.icon = try container.decode(String.self, forKey: .icon)
        } else {
            self.icon = ""
        }
        
        if container.contains(.folderName) {
            self.folderName = try container.decode(String.self, forKey: .folderName)
        } else {
            self.folderName = ""
        }
        
        self.categories = []
        self.segments = []
        self.checkLists = []
    }
    
    //
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Category()
        copy.id = self.id
        copy.languageId = self.languageId
        copy.template = self.template
        copy.name = self.name
        copy.description = self.description
        copy.icon = self.icon
        copy.index = self.index
        copy.folderName = self.folderName
        copy.parent = self.parent
        return copy
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
            Column(name: "template", type: .string, isNotNull: false),
            Column(name: "name", type: .string),
            Column(name: "description", type: .string),
            Column(name: "icon", type: .string),
            Column(name: "index", type: .real),
            Column(name: "folder_name", type: .string),
            Column(name: "parent", type: .int),
            Column(foreignKey: ForeignKey(key: "language_id", table: Table("language"), tableKey: "id"))
        ]
        return array
    }
    
    //
    // MARK: - Hashable
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
    
    /// Search for a list recursive the folderName and return the category with same path
    ///
    /// - Parameter folderName: path of file
    /// - Return: a category
    func searchCategoryBy(id: Int) -> Category? {
        
        if self.id == id {
            return self
        } else {
            for cat in self.categories {
                let category = cat.searchCategoryBy(id: id)
                if category != nil {
                    return category
                }
            }
        }
        
        return nil
    }
}
