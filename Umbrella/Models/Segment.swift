//
//  Segment.swift
//  Umbrella
//
//  Created by Lucas Correa on 06/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Segment: Codable {
    let name: String?
    let index: Float?
    var content: String?
    
    init() {
        name = ""
        index = 0
        content = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case index
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        
        if container.contains(.index) {
            index = try container.decode(Float.self, forKey: .index)
        } else {
            index = 0
        }
        
        content = ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(index, forKey: .index)
    }
    
}
