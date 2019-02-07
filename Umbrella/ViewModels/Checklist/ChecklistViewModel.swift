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
    var totalDonechecklistChecked: ChecklistChecked? {
        let totalDonechecklistChecked: ChecklistChecked = ChecklistChecked()
        totalDonechecklistChecked.subCategoryName = "Total done".localized()
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        
        var totalChecklists = 0
        
        if let language = language {
            //Category
            for category in language.categories {
                //Subcategory
                for subCategory in category.categories {
                    //Difficulty
                    for difficulty in subCategory.categories {
                        //Checklists
                        for _ in difficulty.checkList {
                            totalChecklists += 1
                        }
                    }
                }
            }
            
            totalDonechecklistChecked.totalItemsChecklist = totalChecklists
            totalDonechecklistChecked.totalChecked = self.checklistChecked.count + self.favouriteChecklistChecked.count
        }
        return totalDonechecklistChecked
    }
    
    var favouriteChecklistChecked: [ChecklistChecked] = [ChecklistChecked]()
    
    var sqlManager: SQLManager
    lazy var checklistCheckedDao: ChecklistCheckedDao = {
        let checklistCheckedDao = ChecklistCheckedDao(sqlProtocol: self.sqlManager)
        return checklistCheckedDao
    }()
    
    lazy var favouriteLessonDao: FavouriteLessonDao = {
        let favouriteLessonDao = FavouriteLessonDao(sqlProtocol: self.sqlManager)
        _ = favouriteLessonDao.createTable()
        return favouriteLessonDao
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
        _ = favouriteLessonDao.createTable()
        var list = self.checklistCheckedDao.reportOfItemsChecked()
        
        // Filter by language
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        list = list.filter { $0.languageId == language?.id }
        
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
        
        let favourites = self.favouriteLessonDao.list()
        
        for fav in favourites {
            let check = checklistChecked.filter { $0.subCategoryId == fav.categoryId }.first
            
            if let check = check {
                checklistChecked.removeObject(obj: check)
                self.favouriteChecklistChecked.append(check)
            }
        }
    }
}
