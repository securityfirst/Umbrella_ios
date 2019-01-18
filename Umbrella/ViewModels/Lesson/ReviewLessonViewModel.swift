//
//  ReviewLessonViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 10/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class ReviewLessonViewModel {
    
    //
    // MARK: - Properties
    var segments: [Segment]?
    var checkLists: [CheckList]?
    var category: Category?
    var selected: Any!
    var isGlossary: Bool = false
    
    var sqlManager: SQLManager
    lazy var favouriteLessonDao: FavouriteLessonDao = {
        let favouriteLessonDao = FavouriteLessonDao(sqlProtocol: self.sqlManager)
        return favouriteLessonDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.segments = nil
        self.checkLists = nil
        self.category = nil
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
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
