//
//  Form.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Form: Codable {
    let index: Float?
    let screens: [Screen]
    
    enum CodingKeys: String, CodingKey {
        case index
        case screens
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        index = try container.decode(Float.self, forKey: .index)
        screens = try container.decode([Screen].self, forKey: .screens)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(screens, forKey: .screens)
        try container.encode(index, forKey: .index)
    }
}
