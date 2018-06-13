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
        index = 0
        items = []
    }
    
    enum CodingKeys: String, CodingKey {
        case index
        case items = "list"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        index = try container.decode(Float.self, forKey: .index)
        items = try container.decode([CheckItem].self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(items, forKey: .items)
        try container.encode(index, forKey: .index)
    }
}
