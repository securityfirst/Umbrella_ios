//
//  Screen.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Screen: Codable {
    let name: String
    let items: [ItemForm]
    
    init() {
        self.name = ""
        self.items = []
    }
    
    init(name: String, items: [ItemForm]) {
        self.name = name
        self.items = items
    }
    
    enum CodingKeys: String, CodingKey {
        case items
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.items) {
            self.items = try container.decode([ItemForm].self, forKey: .items)
        } else {
            self.items = []
        }
    }
}
