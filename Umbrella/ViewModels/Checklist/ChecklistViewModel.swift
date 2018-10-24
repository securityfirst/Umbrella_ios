//
//  ChecklistViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class ChecklistViewModel {
    
    //
    // MARK: - Properties
    var itemTotalDone: ChecklistChecked?
    var checklistChecked: [ChecklistChecked] = [ChecklistChecked]()
    var favouriteChecklistChecked: [ChecklistChecked] = [ChecklistChecked]()
    
    var sqlManager: SQLManager
    lazy var checklistCheckedDao: ChecklistCheckedDao = {
        let checklistCheckedDao = ChecklistCheckedDao(sqlProtocol: self.sqlManager)
        return checklistCheckedDao
    }()
    
    lazy var favouriteSegmentDao: FavouriteSegmentDao = {
        let favouriteSegmentDao = FavouriteSegmentDao(sqlProtocol: self.sqlManager)
        _ = favouriteSegmentDao.createTable()
        return favouriteSegmentDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.itemTotalDone = nil
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        _ = checklistCheckedDao.createTable()
    }
    
    //
    // MARK: - Functions
    
    /// Get all item checked
    func reportOfItemsChecked() {
        self.checklistChecked = filterByGreatestDifficultyId()
    }
    
    /// Filter by greatest difficultyId
    ///
    /// - Returns: [ChecklistChecked]
    private func filterByGreatestDifficultyId() -> [ChecklistChecked] {
        _ = checklistCheckedDao.createTable()
        _ = favouriteSegmentDao.createTable()
        let list = self.checklistCheckedDao.reportOfItemsChecked()
        var results = [ChecklistChecked]()
        
        for check in list {
            let duplicate = results.filter { $0.subCategoryId == check.subCategoryId }
            
            if duplicate.count >= 1 {
                for checkDuplicate in duplicate {
                    
                    if check.checklistId > checkDuplicate.checklistId {
                        results.removeObject(obj: checkDuplicate)
                        results.append(check)
                    } else {
                        results.removeObject(obj: check)
                        results.append(checkDuplicate)
                    }
                }
            } else {
                results.append(check)
            }
        }
        removeFavouriteOfList(checklistChecked: &results)
        return results
    }
    
    /// Remove ItemChecked of the list
    ///
    /// - Parameter checklistChecked: [ChecklistChecked]
    func removeFavouriteOfList(checklistChecked: inout [ChecklistChecked]) {
        
        self.favouriteChecklistChecked.removeAll()
        
        let favourites = self.favouriteSegmentDao.list()
        
        for fav in favourites {
            let check = checklistChecked.filter { $0.subCategoryId == fav.categoryId }.first
            
            if let check = check {
                checklistChecked.removeObject(obj: check)
                self.favouriteChecklistChecked.append(check)
            }
        }
    }
}
