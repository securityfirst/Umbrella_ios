//
//  SettingLanguageViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 26/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

class SettingLanguageViewModel: SettingCellProtocol {
    
    //
    // MARK: - Properties
    var items: [SettingItem]
    
    //
    // MARK: - Init
    init() {
        self.items = [
            SettingItem(name: "English".localized(), value: "en", checked: false),
            SettingItem(name: "Spanish".localized(), value: "es", checked: false),
            SettingItem(name: "Chinese".localized(), value: "zh-Hans", checked: false)
        ]
    }
}
