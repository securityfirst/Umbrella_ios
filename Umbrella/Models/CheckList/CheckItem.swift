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
        self.name = ""
        self.label = ""
        self.isChecked = false
    }
    
    init(name: String) {
        self.name = name
        self.label = ""
        self.isChecked = false
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "check"
        case label = "label"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.label) {
            // Get the title of tag ".label"
            self.name = try container.decode(String.self, forKey: .label)
            self.isChecked = true
        } else {
            self.isChecked = false
        }
        
        self.label = ""
    }
}
