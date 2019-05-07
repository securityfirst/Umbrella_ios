//
//  ChecklistViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

class ChecklistViewModel {
    
    //
    // MARK: - Properties
    var itemTotalDone: ChecklistChecked?
    var checklistChecked: [ChecklistChecked] = [ChecklistChecked]()
    
    var totalDoneChecklistChecked: ChecklistChecked? {
        let totalDoneChecklistChecked: ChecklistChecked = ChecklistChecked()
        totalDoneChecklistChecked.subCategoryName = "Total done".localized()
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
                        for checklist in difficulty.checkLists {
                            totalChecklists += checklist.items.filter { $0.isLabel == false }.count
                        }
                    }
                }
            }
            
            let totalFavoriteChecked = self.favouriteChecklistChecked.filter { $0.totalChecked > 0 }
            totalDoneChecklistChecked.totalItemsChecklist = totalChecklists
            totalDoneChecklistChecked.totalChecked = self.checklistChecked.reduce(0, {$0 + $1.totalChecked}) + totalFavoriteChecked.reduce(0, {$0 + $1.totalChecked})
        }
        return totalDoneChecklistChecked
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
    
    func getStructureOfObject(to checklistId: Int) -> (Category, Category, Category, CheckList) {
        
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        
        if let language = language {
            //Category
            for category in language.categories {
                //Subcategory
                for subCategory in category.categories {
                    //Difficulty
                    for difficulty in subCategory.categories {
                        //Checklists
                        for checklist in difficulty.checkLists where checklist.id == checklistId {
                            return (category, subCategory, difficulty, checklist)
                        }
                    }
                }
            }
        }
        
        return (Category(), Category(), Category(), CheckList())
    }
    
    /// Search recursive for whole the categories
    ///
    /// - Parameter id: Int
    /// - Returns: Category?
    func searchCategoryBy(id: Int) -> Category? {
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        
        for cat in (language?.categories)! {
            let found = cat.searchCategoryBy(id: id)
            if (found != nil) {
                return found
            }
        }
        return nil
    }
    
    func difficultyIconBy(id: Int) -> (image: UIImage?, color: UIColor?) {
        let category = searchCategoryBy(id: id)
        
        if let category = category {
            if category.deeplink == "beginner" {
                return (#imageLiteral(resourceName: "iconBeginner"), Lessons.colors[0])
            } else if category.deeplink == "advanced" {
                return (#imageLiteral(resourceName: "iconAdvanced"), Lessons.colors[1])
            } else if category.deeplink == "expert" {
                return (#imageLiteral(resourceName: "iconExpert"), Lessons.colors[2])
            }
        }
        
        return (nil, nil)
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
    
    /// Insert a new ChecklistChecked into the database
    ///
    /// - Parameter checklistChecked: ChecklistChecked
    func insert(_ checklistChecked: ChecklistChecked) {
        _ = self.checklistCheckedDao.insert(checklistChecked)
    }

    /// Remove all checks of a subcategory, checklist and difficulty specify
    ///
    /// - Parameter checklistChecked: [ChecklistChecked]
    func removelAllChecks( checklistChecked: ChecklistChecked) {
       _ =  self.checklistCheckedDao.removeAllChecks(checklistChecked)
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
