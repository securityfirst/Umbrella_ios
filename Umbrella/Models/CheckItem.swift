//
//  CheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Item: Codable {
    let name: String
    let isChecked: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name = "text"
        case isChecked = "label"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        
        if container.contains(.isChecked) {
            isChecked = try container.decode(Bool.self, forKey: .isChecked)
        } else {
            isChecked = false
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(isChecked, forKey: .isChecked)
    }
}

class CheckItem: Codable {
    let index: Float?
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case index
        case items = "list"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        index = try container.decode(Float.self, forKey: .index)
        items = try container.decode([Item].self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
        try container.encode(index, forKey: .index)
    }
}
