//
//  PathwayViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class PathwayViewModel {
    
    //
    // MARK: - Properties
    var category: Category?
    var checklist: CheckList?
    
    var sqlManager: SQLManager
    lazy var pathwayChecklistCheckedDao: PathwayChecklistCheckedDao = {
        let pathwayChecklistCheckedDao = PathwayChecklistCheckedDao(sqlProtocol: self.sqlManager)
        return pathwayChecklistCheckedDao
    }()
    
    lazy var languageDao: LanguageDao = {
        let languageDao = LanguageDao(sqlProtocol: self.sqlManager)
        return languageDao
    }()
    
    lazy var pathwayDao: PathwayDao = {
        let pathwayDao = PathwayDao(sqlProtocol: self.sqlManager)
        return pathwayDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.category = nil
        self.checklist = nil
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        _ = pathwayChecklistCheckedDao.createTable()
    }
    
    //
    // MARK: - Functions
    
    /// Insert a new PathwayChecklistChecked into the database
    ///
    /// - Parameter PathwayChecklistChecked
    func insert(_ pathwayChecklistChecked: PathwayChecklistChecked) {
        _ = self.pathwayChecklistCheckedDao.insert(pathwayChecklistChecked)
    }
    
    /// Remove a PathwayChecklistChecked into the database
    ///
    /// - Parameter PathwayChecklistChecked
    func remove(_ pathwayChecklistChecked: PathwayChecklistChecked) {
        _ = self.pathwayChecklistCheckedDao.remove(pathwayChecklistChecked)
    }
    
    /// Update checklist with Item checked
    func updateChecklistWithItemChecked() {
        
        if let checklist = self.checklist {
            let checkedList = self.pathwayChecklistCheckedDao.list(checklistId: checklist.id)
            
            for item in checklist.items {
                let checked = checkedList.filter {$0.itemId == item.id}.first
                item.checked = (checked != nil)
            }
        }
    }
    
    func getLanguage(name: String) -> Language {
        return self.languageDao.getLanguage(name: name)
    }
    
    func listPathways(languageId: Int) -> Bool {
        self.category = self.pathwayDao.list(languageId: languageId)
        self.category?.checkLists.sort(by: { $0.index! < $1.index!})
        return true
    }
    
    func pathwayFavorite() -> [CheckList] {
        if let checklists = self.category?.checkLists.filter({ $0.favourite == true }) {
            return checklists
        }
        return []
    }
  
    /// Update favourite segment
    func updatePathways() {
        
        self.resetFavouritePathways()
        
        let favouriteList = self.pathwayChecklistCheckedDao.list().filter { $0.itemId == 0}
        
        for favourite in favouriteList {
            
            if let category = self.category {
                let checklist = category.checkLists.filter { $0.id == favourite.checklistId }.first
                if let checklist = checklist {
                    checklist.favourite = true
                }
            }
        }
    }
    
    func resetFavouritePathways() {
        for checklist in (category?.checkLists)! {
            checklist.favourite = false
        }
    }
    
    /// Remove all checks from a checklist
    ///
    /// - Parameter pathwayChecklistChecked: [PathwayChecklistChecked]
    func removelAllChecks( checklist: CheckList) {
        _ =  self.pathwayChecklistCheckedDao.removeAllChecks(checklist)
    }
}
