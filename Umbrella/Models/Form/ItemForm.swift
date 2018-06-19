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
    
    init() {
        self.name = ""
        self.type = ""
        self.label = ""
        self.hint = ""
        self.options = []
    }
    
    init(name: String, type: String, label: String, hint: String, options: [OptionItem]) {
        self.name = name
        self.type = type
        self.label = label
        self.hint = hint
        self.options = options
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case label
        case hint
        case options
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.type) {
            self.type = try container.decode(String.self, forKey: .type)
        } else {
            self.type = ""
        }
        
        if container.contains(.hint) {
            self.hint = try container.decode(String.self, forKey: .hint)
        } else {
            self.hint = ""
        }
        
        if container.contains(.label) {
            self.label = try container.decode(String.self, forKey: .label)
        } else {
            self.label = ""
        }
        
        if container.contains(.options) {
            self.options = try container.decode([OptionItem].self, forKey: .options)
        } else {
            self.options = []
        }
        
    }
}
