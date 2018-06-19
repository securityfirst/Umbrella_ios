//
//  CheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class CheckList: Codable {
    let index: Float?
    let items: [CheckItem]
    
    init() {
        self.index = 0
        self.items = []
    }
    
    init(index: Float, items: [CheckItem]) {
        self.index = index
        self.items = items
    }
    
    enum CodingKeys: String, CodingKey {
        case index
        case items = "list"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.index) {
            self.index = try container.decode(Float.self, forKey: .index)
        } else {
            self.index = 0
        }
        
        if container.contains(.items) {
            self.items = try container.decode([CheckItem].self, forKey: .items)
        } else {
            self.items = []
        }
    }
}
