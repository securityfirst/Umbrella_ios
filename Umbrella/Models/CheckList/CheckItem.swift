//
//  CheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class CheckItem: Codable {
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
