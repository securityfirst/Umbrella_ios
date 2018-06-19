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
        self.name = ""
        self.index = 0
        self.content = ""
    }
    
    init(name: String, index: Float, content: String) {
        self.name = name
        self.index = index
        self.content = content
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case index
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.index) {
            self.index = try container.decode(Float.self, forKey: .index)
        } else {
            self.index = 0
        }
        
       self.content = ""
    }
}
