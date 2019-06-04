//
//  LessonViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 13/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class LessonViewModel {
    
    //
    // MARK: - Properties
    var umbrella: Umbrella?
    var categoriesFilter: [Category] = [Category]()
    var sectionsCollapsed: Set<Int> = Set<Int>()
    fileprivate var isSearch: Bool = false
    var termSearch: String = "" {
        didSet {
            isSearch = termSearch.count > 0
            
            if isSearch {
                
                let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
                let language = umbrella?.languages.filter { $0.name == languageName}.first
                
                if let language = language {
                    copyList(originalList: language.categories)
                }
            } else {
                sectionsCollapsed.removeAll()
            }
        }
    }
    
    var sqlManager: SQLManager
    lazy var difficultyRuleDao: DifficultyRuleDao = {
        let difficultyRuleDao = DifficultyRuleDao(sqlProtocol: self.sqlManager)
        return difficultyRuleDao
    }()
    
    lazy var favouriteLessonDao: FavouriteLessonDao = {
        let favouriteLessonDao = FavouriteLessonDao(sqlProtocol: self.sqlManager)
        _ = favouriteLessonDao.createTable()
        return favouriteLessonDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    /// Get all categories of a language
    ///
    /// - Parameter lang: String
    /// - Returns: [Category]
    func getCategories(ofLanguage lang: String = Locale.current.languageCode!) -> [Category] {
        
        var language = umbrella?.languages.filter { $0.name == lang}.first
        
        if language == nil {
            // if language doesn't exist get the default en - English
            language = umbrella?.languages.filter { $0.name == "en"}.first
        }
        
        if let language = language {
            
            if self.isSearch {
                return filterCategories()
            }

            return language.categories.filter { Int($0.index ?? -1) > 0 }
        }
        
        return [Category]()
    }
    
    /// Copy a list of Categories
    ///
    /// - Parameter originalList: [Category]
    fileprivate func copyList(originalList: [Category]) {
        
        self.categoriesFilter.removeAll()
        
        for category in originalList {
            
            // Category
            let copyCat: Category = (category.copy() as? Category)!
            
            copySubCategories(category, copyCat)
            copySegments(category, copyCat)
            copyChecklists(category, copyCat)
            
            self.categoriesFilter.append(copyCat)
        }
    }
    
    /// Copy a list of segments
    ///
    /// - Parameters:
    ///   - category: Category
    ///   - copyCategory: Category
    fileprivate func copySegments(_ category: Category, _ copyCategory: Category) {
        
        // Segments
        for segment in category.segments {
            let copySeg = (segment.copy() as? Segment)!
            copyCategory.segments.append(copySeg)
        }
    }
    
    /// Copy a list of checklists
    ///
    /// - Parameters:
    ///   - category: Category
    ///   - copyCategory: Category
    fileprivate func copyChecklists(_ category: Category, _ copyCategory: Category) {
        // Checklist
        for checklist in category.checkLists {
            let copyChecklist = (checklist.copy() as? CheckList)!
            copyCategory.checkLists.append(copyChecklist)
            
            // CheckItem
            for checkItem in checklist.items {
                let copyCheckItem = (checkItem.copy() as? CheckItem)!
                copyChecklist.items.append(copyCheckItem)
            }
        }
    }
    
    /// Copy a list of difficuties
    ///
    /// - Parameters:
    ///   - category: Category
    ///   - copyCategory: Category
    fileprivate func copyDifficulties(_ category: Category, _ copyCategory: Category) {
        
        // Difficulty
        for difficulty in category.categories {
            let copyDifficulty = (difficulty.copy() as? Category)!
            copyCategory.categories.append(copyDifficulty)
            
            copySegments(difficulty, copyDifficulty)
            copyChecklists(difficulty, copyDifficulty)
        }
    }
    
    /// Copy a list of Subcategories
    ///
    /// - Parameters:
    ///   - category: Category
    ///   - copyCategory: Category
    fileprivate func copySubCategories(_ category: Category, _ copyCategory: Category) {
        
        // SubCategory
        for subcategory in category.categories {
            let copySub = (subcategory.copy() as? Category)!
            copyCategory.categories.append(copySub)
            
            copyDifficulties(subcategory, copySub)
        }
    }
    
    /// Filter Categories for the term
    ///
    /// - Returns: [Category]
    fileprivate func filterCategories() -> [Category] {
        
        var finalList = [Category]()
        
        for parent in self.categoriesFilter {
            let children = parent.categories.filter { $0.name!.lowercased().contains(termSearch.lowercased()) }
            if children.count > 0 {
                let copyParent = parent
                copyParent.categories = children
                finalList.append(copyParent)
            }
        }
        
        for index in finalList.indices {
            //Collapse all
            sectionsCollapsed.insert(index+1)
        }
        
        return finalList
    }
    
    /// Check if the headerView is collapsed in array
    ///
    /// - Parameter section: Int
    /// - Returns: Bool
    func isCollapsed(section: Int) -> Bool {
        let count = sectionsCollapsed.filter { $0 == section }.count
        return count > 0
    }
    
    /// Check if there is rule to a difficulty
    ///
    /// - Parameter difficultyRule: DifficultyRule
    /// - Returns: Int
    func isExistRule(to difficultyRule: DifficultyRule) -> Int {
        return self.difficultyRuleDao.isExistRule(to: difficultyRule)
    }
    
    /// Load all favourite segments
    ///
    /// - Returns: [Segment]
    func loadFavourites() -> [Segment] {
        
        _ = favouriteLessonDao.createTable()
        var segments: [Segment] = [Segment]()
        
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let categories = getCategories(ofLanguage: languageName)
        let favourites = self.favouriteLessonDao.list()
        
        for favouriteSegment in favourites {
            
            for category in categories {
                
                // if segment doesn't have difficulty
                if category.id == favouriteSegment.categoryId {
                    let segment = category.segments.filter {$0.id == favouriteSegment.segmentId}.first
                    
                    if let segment = segment {
                        segment.favourite = true
                        segments.append(segment)
                    }
                    
                    for subCategory in category.categories {
                        let segment = subCategory.segments.filter {$0.id == favouriteSegment.segmentId}.first
                        
                        if let segment = segment {
                            segment.favourite = true
                            segments.append(segment)
                        }
                    }
                } else {
                    // if segment has difficulty
                    let categ = category.categories.filter {$0.id == favouriteSegment.categoryId}.first
                    
                    if let categ = categ {
                        let difficulty = categ.categories.filter {$0.id == favouriteSegment.difficultyId}.first
                        
                        if let difficulty = difficulty {
                            let segment = difficulty.segments.filter {$0.id == favouriteSegment.segmentId}.first
                            
                            if let segment = segment {
                                segment.favourite = true
                                segments.append(segment)
                            }
                        }
                    }
                }
            }
        }
        
        return segments
    }
}
