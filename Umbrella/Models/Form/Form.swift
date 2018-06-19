//
//  Form.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Form: Codable {
    var name: String {
        if screens.count > 0 {
            return screens.first!.name
        }
        return ""
    }
    
    let screens: [Screen]
    
    init() {
        self.screens = []
    }
    
    init(screens: [Screen]) {
        self.screens = screens
    }
    
    enum CodingKeys: String, CodingKey {
        case screens
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.screens) {
            self.screens = try container.decode([Screen].self, forKey: .screens)
        } else {
            self.screens = []
        }
    }
}
