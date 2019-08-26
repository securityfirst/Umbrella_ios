//
//  Form.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class Form: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    var languageId: Int
    var language: String
    
    //
    // MARK: - Properties
    var name: String
    var file: String!
    var screens: [Screen]
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.languageId = -1
        self.language = ""
        self.name = ""
        self.screens = []
    }
    
    init(screens: [Screen]) {
        self.id = -1
        self.languageId = -1
        self.language = ""
        self.name = ""
        self.screens = screens
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case languageId = "language_id"
        case language
        case name = "title"
        case file = "file"
        case screens
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        self.languageId = try container.decodeIfPresent(Int.self, forKey: .languageId) ?? -1
        self.language = try container.decodeIfPresent(String.self, forKey: .language) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.file = try container.decodeIfPresent(String.self, forKey: .file) ?? ""
        self.screens = try container.decodeIfPresent([Screen].self, forKey: .screens) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(screens, forKey: .screens)
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "form"
    var tableName: String {
        return Form.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "title", type: .string),
            Column(name: "file", type: .string),
            Column(foreignKey: ForeignKey(key: "language_id", table: Table("language"), tableKey: "id"))
        ]
        return array
    }
}
