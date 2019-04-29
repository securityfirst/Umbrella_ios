//
//  CustomChecklistViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class CustomChecklistViewModel {
    
    //
    // MARK: - Properties
    var customChecklists: [CustomChecklist] = [CustomChecklist]()
    var customChecklistChecked: [CustomChecklistChecked] = [CustomChecklistChecked]()
    var sqlManager: SQLManager
    lazy var customChecklistDao: CustomChecklistDao = {
        let customChecklistDao = CustomChecklistDao(sqlProtocol: self.sqlManager)
        return customChecklistDao
    }()
    
    lazy var customCheckItemDao: CustomCheckItemDao = {
        let customCheckItemDao = CustomCheckItemDao(sqlProtocol: self.sqlManager)
        return customCheckItemDao
    }()
    
    lazy var customChecklistCheckedDao: CustomChecklistCheckedDao = {
        let customChecklistCheckedDao = CustomChecklistCheckedDao(sqlProtocol: self.sqlManager)
        return customChecklistCheckedDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        _ = customChecklistDao.createTable()
        _ = customCheckItemDao.createTable()
        _ = customChecklistCheckedDao.createTable()
    }
    
    func loadCustomChecklist() {
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        self.customChecklistChecked = self.customChecklistCheckedDao.list()
        
        if let language = language {
            self.customChecklists = self.customChecklistDao.listOfLanguage(languageId: language.id)
            self.customChecklists.forEach { customChecklist in
                customChecklist.items = self.customCheckItemDao.listOfChecklist(checkListId: customChecklist.id)
            }
        }
    }
    
    func insertCustomChecklist(name: String) -> CustomChecklist {
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        var customChecklist = CustomChecklist(name: name)
        if language != nil {
            customChecklist = CustomChecklist(name: name, languageId: language!.id)
            let rowId = self.customChecklistDao.insert(customChecklist)
            customChecklist.id = Int(rowId)
        }
        return customChecklist
    }
    
    func removeCustomChecklist(customChecklist: CustomChecklist) {
        _ = self.customChecklistCheckedDao.removeAll(customChecklist.id)
        _ = self.customCheckItemDao.removeAll(customChecklist.id)
        _ = self.customChecklistDao.remove(customChecklist)
    }
    
    func removeCustomChecklistAll() {
        let list = self.customChecklistDao.list()
        for customChecklist in list {
            _ = self.customChecklistCheckedDao.removeAll(customChecklist.id)
            _ = self.customCheckItemDao.removeAll(customChecklist.id)
            _ = self.customChecklistDao.remove(customChecklist)
        }
    }
}
