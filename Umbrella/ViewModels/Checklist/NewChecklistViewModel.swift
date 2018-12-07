//
//  NewChecklistViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 03/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class NewChecklistViewModel {
    
    //
    // MARK: - Properties
    var name: String!
    var customChecklist: CustomChecklist!
    var customChecklistChecked: [CustomChecklistChecked] = [CustomChecklistChecked]()
    var sqlManager: SQLManager
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
    }
    
    //
    // MARK: - Functions
    
    func updateChecklistCheckedOfCustomChecklist(customChecklistId: Int) {
        self.customChecklistChecked = self.customChecklistCheckedDao.listOfCustomChecklist(customChecklistId)
    }
    
    /// Insert a new CustomCheckItem into the database
    ///
    /// - Parameter customCheckItem: CustomCheckItem
    func insertCustomCheckItem(_ customCheckItem: CustomCheckItem) -> Int {
        return Int(self.customCheckItemDao.insert(customCheckItem))
    }
    
    /// Remove a CustomCheckItem into the database
    ///
    /// - Parameter customCheckItem: CustomCheckItem
    func removeCustomCheckItem(_ customCheckItem: CustomCheckItem) {
        _ = self.customCheckItemDao.remove(customCheckItem)
        _ = self.customChecklistCheckedDao.remove(customCheckItem.id)
    }
    
    /// Insert a new CustomCheckItem into the database
    ///
    /// - Parameter customCheckItem: CustomCheckItem
    func insertCustomCheckChecked(_ customCheckItem: CustomCheckItem) {
        _ = self.customChecklistCheckedDao.insert(customCheckItem)
    }
    
    /// Remove a CustomCheckItem into the database
    ///
    /// - Parameter customCheckItem: CustomCheckItem
    func removeCustomCheckChecked(_ customCheckItem: CustomCheckItem) {
        _ = self.customChecklistCheckedDao.remove(customCheckItem.id)
    }
    
}
