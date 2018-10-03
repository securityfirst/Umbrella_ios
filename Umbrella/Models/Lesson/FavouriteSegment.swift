//
//  FavouriteSegment.swift
//  Umbrella
//
//  Created by Lucas Correa on 01/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class FavouriteSegment: Codable, TableProtocol {
    
    //
    // MARK: - Properties
    var categoryId: Int
    var difficultyId: Int
    var segmentId: Int
    
    //
    // MARK: - Initializers
    init() {
        self.categoryId = -1
        self.difficultyId = -1
        self.segmentId = -1
    }
    
    init(categoryId: Int, difficultyId: Int, segmentId: Int) {
        self.categoryId = categoryId
        self.difficultyId = difficultyId
        self.segmentId = segmentId
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case categoryId = "category_id"
        case difficultyId = "difficulty_id"
        case segmentId = "segment_id"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.categoryId) {
            self.categoryId = try container.decode(Int.self, forKey: .categoryId)
        } else {
            self.categoryId = -1
        }
        
        if container.contains(.difficultyId) {
            self.difficultyId = try container.decode(Int.self, forKey: .difficultyId)
        } else {
            self.difficultyId = -1
        }
        
        if container.contains(.segmentId) {
            self.segmentId = try container.decode(Int.self, forKey: .segmentId)
        } else {
            self.segmentId = -1
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "favourite_segment"
    var tableName: String {
        return FavouriteSegment.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "category_id", type: .int),
            Column(name: "difficulty_id", type: .int),
            Column(name: "segment_id", type: .int)
        ]
        return array
    }
}
