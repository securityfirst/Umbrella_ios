//
//  SettingsViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

enum TableSection: Int {
    case general = 0, feed, feed2, total
}

class SettingsViewModel {
    
    //
    // MARK: - Properties
    
    var items: [TableSection : [(title: String, subtitle: String, hasAccessory: Bool, hasSwitch: Bool)]]!
    let sqlManager: SQLManager!
    //
    // MARK: - Init
    init() {
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        loadItems()
    }
    
    func loadItems() {
        let language: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        var languageSelected = ""
        
        if language == "en" {
            languageSelected = "English".localized()
        } else if language == "es" {
            languageSelected = "Spanish".localized()
        } else if language == "zh-Hans" {
            languageSelected = "Chinese".localized()
        }
        
        self.items = [
            .general: [
                (title: "Skip password".localized(), subtitle: "Don't ask for password again".localized(), hasAccessory: false, hasSwitch: true),
                (title: "Refresh from the server".localized(), subtitle: "Refresh from the server".localized(), hasAccessory: false, hasSwitch: false),
                (title: "Change repository".localized(), subtitle: "Change repository".localized(), hasAccessory: false, hasSwitch: false),
                (title: "Select Language".localized(), subtitle: languageSelected, hasAccessory: true, hasSwitch: false),
                (title: "Import your data".localized(), subtitle: "Import your data".localized(), hasAccessory: false, hasSwitch: false),
                (title: "Export your data".localized(), subtitle: "Export your data".localized(), hasAccessory: false, hasSwitch: false)
            ],
            .feed: [
                (title: "Refresh interval for custom feeds".localized(), subtitle: "30 min".localized(), hasAccessory: true, hasSwitch: false),
                (title: "Your location".localized(), subtitle: "Your location".localized(), hasAccessory: true, hasSwitch: false),
                (title: "Security feed sources".localized(), subtitle: "Security feed sources".localized(), hasAccessory: true, hasSwitch: false)
            ],
            .feed2: [
                (title: "Show updates as notification".localized(), subtitle: "Show updates as notification".localized(), hasAccessory: false, hasSwitch: true)
            ]
        ]
    }
    
    func updateDatabaseToObject() -> (languages: [Language], forms: [Form], formAnswers: [FormAnswer]) {
        var umbrellaDatabase = UmbrellaDatabase(sqlProtocol: self.sqlManager)
        umbrellaDatabase.databaseToObject()
        
        return (umbrellaDatabase.languages, umbrellaDatabase.forms, umbrellaDatabase.formAnswers)
    }
}
