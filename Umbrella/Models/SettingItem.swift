//
//  SettingItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 20/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class SettingItem {
    
    var icon: String
    var name: String
    var value: String
    var checked: Bool = false
    
    init() {
        self.icon = ""
        self.name = ""
        self.value = ""
    }
    
    init(icon: String = "", name: String, value: String, checked: Bool) {
        self.icon = icon
        self.name = name
        self.value = value
        self.checked = checked
    }
}
