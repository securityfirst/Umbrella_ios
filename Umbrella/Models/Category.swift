//
//  Category.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Category: Codable, TableProtocol, FolderProtocol {
    var name: String?
    let index: Float?
    var folderName: String?
    var categories: [Category]
    var segments: [Segment]
    var checkList: [CheckList]
    
    init() {
        name = ""
        index = 0
        folderName = ""
        categories = []
        segments = []
        checkList = []
    }
    
    init(name: String, index: Float, folderName: String = "") {
        self.name = name
        self.index = index
        self.folderName = folderName
        categories = []
        segments = []
        checkList = []
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case index
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.index) {
            index = try container.decode(Float.self, forKey: .index)
        } else {
            index = 0
        }
        
        if container.contains(.name) {
            name = try container.decode(String.self, forKey: .name)
        } else {
            name = ""
        }
        
        folderName = ""
        categories = []
        segments = []
        checkList = []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(index, forKey: .index)
    }
    
    //
    // MARK: - TableProtocol
    var tableName: String = "category"
    
    func columns() -> [String : String] {
        let array = [
            "id":"Primary",
            "name": "String",
            "index": "Int",
            "parent":"Int"
        ]
        return array
    }
}
