//
//  ItemForm.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class ItemForm: Codable {
    let name: String
    let type: String
    let label: String
    let hint: String
    let options: [OptionItem]
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case label
        case hint
        case options
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        
        if container.contains(.hint) {
            hint = try container.decode(String.self, forKey: .hint)
        } else {
            hint = ""
        }
        
        if container.contains(.label) {
            label = try container.decode(String.self, forKey: .label)
        } else {
            label = ""
        }
        
        if container.contains(.options) {
            options = try container.decode([OptionItem].self, forKey: .options)
        } else {
            options = []
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(label, forKey: .label)
    }
}
