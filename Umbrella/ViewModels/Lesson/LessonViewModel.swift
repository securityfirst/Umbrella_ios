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
                let language = umbrella?.languages.filter { $0.name == Locale.current.languageCode!}.first
                
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
    
    lazy var favouriteSegmentDao: FavouriteSegmentDao = {
        let favouriteSegmentDao = FavouriteSegmentDao(sqlProtocol: self.sqlManager)
         _ = favouriteSegmentDao.createTable()
        return favouriteSegmentDao
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
        
        let language = umbrella?.languages.filter { $0.name == lang}.first
        
        if let language = language {
            
            if self.isSearch {
                return filterCategories()
            }
            
            return language.categories
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
            
            // SubCategory
            for subcategory in category.categories {
                let copySub = (subcategory.copy() as? Category)!
                copyCat.categories.append(copySub)

                // Difficulty
                for difficulty in subcategory.categories {
                    let copyDifficulty = (difficulty.copy() as? Category)!
                    copySub.categories.append(copyDifficulty)
                    
                    // Segments
                    for segment in difficulty.segments {
                        let copySeg = (segment.copy() as? Segment)!
                        copyDifficulty.segments.append(copySeg)
                    }
                    
                    // Checklist
                    for checklist in difficulty.checkList {
                        let copyChecklist = (checklist.copy() as? CheckList)!
                        copyDifficulty.checkList.append(copyChecklist)
                        
                        // CheckItem
                        for checkItem in checklist.items {
                            let copyCheckItem = (checkItem.copy() as? CheckItem)!
                            copyChecklist.items.append(copyCheckItem)
                        }
                    }
                }
            }
            
            // Segments
            for segment in category.segments {
                let copySeg = (segment.copy() as? Segment)!
                copyCat.segments.append(copySeg)
            }

            // Checklist
            for checklist in category.checkList {
                let copyChecklist = (checklist.copy() as? CheckList)!
                copyCat.checkList.append(copyChecklist)
            }
            
            self.categoriesFilter.append(copyCat)
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
        
        _ = favouriteSegmentDao.createTable()
        var segments: [Segment] = [Segment]()
        
        let categories = getCategories()
        let favourites = self.favouriteSegmentDao.list()
        
        // I need to refactor it
        for favouriteSegment in favourites {
            
            for category in categories {
                
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
        
        return segments
    }
}
