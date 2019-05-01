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
    var items: [SettingItem]!
    
    //
    // MARK: - Init
    init() {
        loadItems()
    }
    
    func loadItems() {
        self.items = [
            SettingItem(icon: "GB", name: "English".localized(), value: "en", checked: false),
            SettingItem(icon: "ES", name: "Spanish".localized(), value: "es", checked: false),
            SettingItem(icon: "CN", name: "Chinese".localized(), value: "zh-Hant", checked: false),
            SettingItem(icon: "AR", name: "Arabic".localized(), value: "ar", checked: false),
            SettingItem(icon: "IR", name: "Iranian".localized(), value: "fa", checked: false)
//            SettingItem(icon: "FR", name: "French".localized(), value: "fr", checked: false),
//            SettingItem(icon: "RU", name: "Russian".localized(), value: "ru", checked: false)
        ]
    }
}
