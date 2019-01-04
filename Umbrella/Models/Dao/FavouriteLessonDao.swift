//
//  FavouriteSegmentDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 01/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct FavouriteLessonDao: DaoProtocol {
    
    //
    // MARK: - Properties
    let sqlProtocol: SQLProtocol
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameter sqlProtocol: SQLProtocol
    init(sqlProtocol: SQLProtocol) {
        self.sqlProtocol = sqlProtocol
    }
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return self.sqlProtocol.create(table: FavouriteLesson())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [FavouriteLesson] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(FavouriteLesson.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: FavouriteLesson.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: FavouriteLesson) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(FavouriteLesson.table) ('category_id', 'difficulty_id', 'segment_id') VALUES (\(object.categoryId) , \(object.difficultyId), \(object.segmentId) )")
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// Delete favouriteLesson to segmentId in database
    ///
    /// - Parameter segmentId: Int
    /// - Returns: bool
    func remove(_ segmentId: Int) -> Bool {
        let sql = "DELETE FROM \(FavouriteLesson.table) WHERE segment_id = \(segmentId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// Delete favouriteLesson to categoryId and difficultyId in database
    ///
    /// - Parameter categoryId: Int
    /// - Parameter difficultyId: Int
    /// - Returns: bool
    func remove(_ categoryId: Int, difficultyId: Int) -> Bool {
        let sql = "DELETE FROM \(FavouriteLesson.table) WHERE category_id = \(categoryId) AND difficulty_id = \(difficultyId) AND segment_id = -1"
        return self.sqlProtocol.remove(withQuery: sql)
    }
}
