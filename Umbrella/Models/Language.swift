//
//  Language.swift
//  Umbrella
//
//  Created by Lucas Correa on 06/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Language: Codable, TableProtocol, FolderProtocol {
    
    // Used in parser from the database to object
    var id: Int
    
    //
    // MARK: - Properties
    let name: String
    var categories: [Category]
    var folderName: String?
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.name = ""
        self.categories = []
        self.folderName = ""
    }
    
    init(name: String) {
        self.id = -1
        self.name = name
        self.categories = []
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        self.folderName = ""
        self.categories = []
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "language"
    var tableName: String {
        return Language.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "name", type: .string)
        ]
        return array
    }
}
