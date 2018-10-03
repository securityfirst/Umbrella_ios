//
//  RssItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class RssItem: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    
    //
    // MARK: - Properties
    var url: String
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.url = ""
    }
    
    init(url: String) {
        self.id = -1
        self.url = url
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.url) {
            self.url = try container.decode(String.self, forKey: .url)
        } else {
            self.url = ""
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "rss"
    var tableName: String {
        return RssItem.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "url", type: .string)
        ]
        return array
    }
}
