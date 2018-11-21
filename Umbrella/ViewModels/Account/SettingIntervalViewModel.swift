//
//  SettingIntervalViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 20/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

class SettingIntervalViewModel: SettingCellProtocol {
    
    //
    // MARK: - Properties
    var items: [SettingItem]
    
    //
    // MARK: - Init
    init() {
       self.items = [
        SettingItem(name: "30 min", value: "30", checked: false),
        SettingItem(name: "1 hour", value: "60", checked: false),
        SettingItem(name: "2 hours", value: "120", checked: false),
        SettingItem(name: "4 hours", value: "240", checked: false),
        SettingItem(name: "6 hours", value: "360", checked: false),
        SettingItem(name: "12 hours", value: "720", checked: false),
        SettingItem(name: "24 hours", value: "1440", checked: false),
        SettingItem(name: "Manually".localized(), value: "-1", checked: false)
        ]
    }
}
