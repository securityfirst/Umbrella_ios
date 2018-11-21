//
//  SettingSourceViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

class SettingSourceViewModel: SettingCellProtocol {
    
    //
    // MARK: - Properties
    var items: [SettingItem]
    
    //
    // MARK: - Init
    init() {
        self.items = [
            SettingItem(name: "ReliefWeb", value: "0", checked: false),
            SettingItem(name: "UN", value: "1", checked: false),
            SettingItem(name: "FCO", value: "2", checked: false),
            SettingItem(name: "CDC", value: "3", checked: false),
            SettingItem(name: "Global Disaster and Alert Coordination System", value: "4", checked: false),
            SettingItem(name: "US State Department Country Warnings", value: "5", checked: false)
        ]
    }
}
