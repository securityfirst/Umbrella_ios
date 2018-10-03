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
    var categories: [Category] = [Category]()
    var sectionsCollapsed: [Int] = [Int]()
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
            return language.categories
        }
        
        return [Category]()
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
    
    func loadFavourites() -> [Segment] {
        
        var segments: [Segment] = [Segment]()
        
        let categories = getCategories()
        let favourites = self.favouriteSegmentDao.list()
        
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
