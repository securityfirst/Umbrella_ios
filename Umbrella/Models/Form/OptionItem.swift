//
//  OptionItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class OptionItem: Codable {
    let label: String
    let value: String
    
    init() {
        self.label = ""
        self.value = ""
    }
    
    init(label: String, value: String) {
        self.label = label
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey {
        case label
        case value
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.label) {
            self.label = try container.decode(String.self, forKey: .label)
        } else {
            self.label = ""
        }
        
        if container.contains(.label) {
            self.value = try container.decode(String.self, forKey: .value)
        } else {
            self.value = ""
        }
    }
}
