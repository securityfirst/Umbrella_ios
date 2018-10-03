//
//  FavouriteSegmentDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 01/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct FavouriteSegmentDao: DaoProtocol {
    
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
        return self.sqlProtocol.create(table: FavouriteSegment())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [FavouriteSegment] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(FavouriteSegment.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: FavouriteSegment.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: FavouriteSegment) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(FavouriteSegment.table) ('category_id', 'difficulty_id', 'segment_id') VALUES (\(object.categoryId) , \(object.difficultyId), \(object.segmentId) )")
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// Delete favouriteSegment to segmentId in database
    ///
    /// - Parameter segmentId: Int
    /// - Returns: bool
    func remove(_ segmentId: Int) -> Bool {
        let sql = "DELETE FROM \(FavouriteSegment.table) WHERE segment_id = \(segmentId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
}
