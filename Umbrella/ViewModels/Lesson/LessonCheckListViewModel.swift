//
//  LessonCheckListViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class LessonCheckListViewModel {
    
    //
    // MARK: - Properties
    var checklist: CheckList?
    var category: Category?
    var sqlManager: SQLManager
    lazy var checklistCheckedDao: ChecklistCheckedDao = {
        let checklistCheckedDao = ChecklistCheckedDao(sqlProtocol: self.sqlManager)
        return checklistCheckedDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.category = nil
        self.checklist = nil
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        _ = checklistCheckedDao.createTable()
    }
    
    //
    // MARK: - Functions
    
    /// Insert a new ChecklistChecked into the database
    ///
    /// - Parameter checklistChecked: ChecklistChecked
    func insert(_ checklistChecked: ChecklistChecked) {
        _ = self.checklistCheckedDao.insert(checklistChecked)
    }
    
    /// Insert a new ChecklistChecked into the database
    ///
    /// - Parameter checklistChecked: ChecklistChecked
    func remove(_ checklistChecked: ChecklistChecked) {
        _ = self.checklistCheckedDao.remove(checklistChecked)
    }
    
    /// Update checklist with Item checked
    func updateChecklistWithItemChecked() {
        
        if let checklist = self.checklist {
            let checkedList = self.checklistCheckedDao.list(checklistId: checklist.id)
            
            for item in checklist.items {
                
                let checked = checkedList.filter {$0.itemId == item.id}.first
                
                item.checked = (checked != nil)
            }
        }
    }
}
