//
//  CheckItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class CheckItem: Codable {
    
    //Name and label are same information (the title of checkbox), so a label is used to when the checkbox is checked and as I need to save the name, I create the attribute label only to get data.
    var name: String
    private let label: String
    
    var isChecked: Bool?
    
    init() {
        name = ""
        label = ""
        isChecked = false
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "check"
        case label = "label"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.name) {
            name = try container.decode(String.self, forKey: .name)
        } else {
            name = ""
        }
        
        if container.contains(.label) {
            // Get the title of tag ".label"
            name = try container.decode(String.self, forKey: .label)
            isChecked = true
        } else {
            isChecked = false
        }
        
        label = ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(label, forKey: .label)
    }
}
