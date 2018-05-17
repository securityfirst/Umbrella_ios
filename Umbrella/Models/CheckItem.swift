//
//  CheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct CheckItem: Codable {
    let category: Int?
    
    enum CodingKeys: String, CodingKey {
        case category
    }
}
