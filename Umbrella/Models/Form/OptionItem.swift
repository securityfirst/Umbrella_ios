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
        label = ""
        value = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case label
        case value
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        label = try container.decode(String.self, forKey: .label)
        value = try container.decode(String.self, forKey: .value)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(label, forKey: .label)
        try container.encode(value, forKey: .value)
    }
}
