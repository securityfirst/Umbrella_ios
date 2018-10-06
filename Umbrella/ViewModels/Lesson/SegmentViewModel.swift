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
    var sqlManager: SQLManager
    lazy var difficultyRuleDao: DifficultyRuleDao = {
        let difficultyRuleDao = DifficultyRuleDao(sqlProtocol: self.sqlManager)
        return difficultyRuleDao
    }()
    
    lazy var favouriteSegmentDao: FavouriteSegmentDao = {
        let favouriteSegmentDao = FavouriteSegmentDao(sqlProtocol: self.sqlManager)
        return favouriteSegmentDao
    }()
    
    //
    // MARK: - Init
    init() {
        category = nil
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
     }
    
    //
    // MARK: - Functions
    
    /// Update favourite segment
    func updateFavouriteSegment() {
        
        let favouriteList = self.favouriteSegmentDao.list()
        
        for favourite in favouriteList where category?.id == favourite.difficultyId {
            
            let segment = category?.segments.filter {$0.id == favourite.segmentId}.first
            
            if let segment = segment {
                segment.favourite = true
            }
        }
    }
    
    /// Insert a new DifficultyRule into the database
    ///
    /// - Parameter difficultyRule: DifficultyRule
    func insert(_ difficultyRule: DifficultyRule) {
        _ = self.difficultyRuleDao.insert(difficultyRule)
    }
    
    func insert(_ favouriteSegment: FavouriteSegment) {
        _ = self.favouriteSegmentDao.insert(favouriteSegment)
    }
    
    func remove(_ segmentId: Int) {
        _ = self.favouriteSegmentDao.remove(segmentId)
    }
    
}
