//
//  SegmentViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class SegmentViewModel {
    
    //
    // MARK: - Properties
    var category: Category?
    var difficulties: [Category] = [Category]()
    var segmentsFilter: [Segment] = [Segment]()
    fileprivate var isSearch: Bool = false
    
    var termSearch: String = "" {
        didSet {
            isSearch = termSearch.count > 0
            
            if isSearch, let category = category {
                copyList(originalList: category.segments)
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
        return favouriteLessonDao
    }()
    
    //
    // MARK: - Init
    init() {
        category = nil
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    //
    // MARK: - Functions
    
    /// Get all categories of a language
    ///
    /// - Parameter lang: String
    /// - Returns: [Category]
    func getSegments() -> [Segment] {
        
        if self.isSearch {
            return filterSegments()
        }
        
        if let category = category {
            return category.segments
        }
        
        return [Segment]()
    }
    
    /// Update favourite segment
    func updateFavouriteSegment() {
        
        self.resetFavouriteSegments()
        
        let favouriteList = self.favouriteLessonDao.list()
        
        for favourite in favouriteList where category?.id == favourite.difficultyId {
            
            let segment = getSegments().filter {$0.id == favourite.segmentId}.first
            
            if let segment = segment {
                segment.favourite = true
            } else {
                for checklist in (category?.checkList)! {
                    if checklist.categoryId == favourite.difficultyId {
                        checklist.favourite = true
                    } else {
                        checklist.favourite = false
                    }
                }
            }
        }
        
        // Favourite Screen
        if category?.id == -1 {
            for segment in getSegments() {
                segment.favourite = true
            }
        }
    }
    
    /// Reset all flag favourite of the segments
    func resetFavouriteSegments() {
        for segment in getSegments() {
            segment.favourite = false
        }
    }
    
    /// Copy a list of Categories
    ///
    /// - Parameter originalList: [Category]
    fileprivate func copyList(originalList: [Segment]) {
        
        self.segmentsFilter.removeAll()
        
        // Segments
        for segment in originalList {
            let copySeg = (segment.copy() as? Segment)!
            self.segmentsFilter.append(copySeg)
        }
        
    }
    
    /// Filter Segments for the term
    ///
    /// - Returns: [Segment]
    fileprivate func filterSegments() -> [Segment] {
        
        let finalList = [Segment]()
        
        let children = segmentsFilter.filter { $0.name!.lowercased().contains(termSearch.lowercased()) || $0.content!.lowercased().contains(termSearch.lowercased()) }
        if children.count > 0 {
            return children
        }
        
        return finalList
    }
    
    /// Insert a new DifficultyRule into the database
    ///
    /// - Parameter difficultyRule: DifficultyRule
    func insert(_ difficultyRule: DifficultyRule) {
        _ = self.difficultyRuleDao.insert(difficultyRule)
    }
    
    /// Insert a new FavouriteSegment into the database
    ///
    /// - Parameter favouriteSegment: FavouriteSegment
    func insert(_ favouriteSegment: FavouriteLesson) {
        _ = self.favouriteLessonDao.insert(favouriteSegment)
    }
    
    /// Remove a favouriteSegment of the database
    ///
    /// - Parameter segmentId: Int
    func remove(_ segmentId: Int) {
        _ = self.favouriteLessonDao.remove(segmentId)
    }
    
    /// Remove a favouriteSegment of the database
    ///
    /// - Parameter segmentId: Int
    func removeFavouriteChecklist(_ categoryId: Int, difficultyId: Int) {
        _ = self.favouriteLessonDao.remove(categoryId, difficultyId: difficultyId)
    }
    
}
