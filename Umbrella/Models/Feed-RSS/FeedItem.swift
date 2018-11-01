//
//  FeedItem.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class FeedItem: Codable {
    
    //
    // MARK: - Properties
    var title: String
    var updatedAt: Int64
    var description: String
    var dateString: String {
        let timeInterval = TimeInterval(updatedAt)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let dateFormatter = Global.dateFormatter
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat =  "MM/dd/yyyy hh:mm a"
        let dateFormat = dateFormatter.string(from: date as Date)
        return dateFormat
    }
    var url: String
    
    //
    // MARK: - Initializers
    init() {
        self.url = ""
        self.title = ""
        self.updatedAt = 0
        self.description = ""
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case url
        case title
        case updatedAt = "updated_at"
        case description
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.url) {
            self.url = try container.decode(String.self, forKey: .url)
        } else {
            self.url = ""
        }
        
        if container.contains(.title) {
            self.title = try container.decode(String.self, forKey: .title)
        } else {
            self.title = ""
        }
        
        if container.contains(.updatedAt) {
            self.updatedAt = try container.decode(Int64.self, forKey: .updatedAt)
        } else {
            self.updatedAt = 0
        }
        
        if container.contains(.description) {
            self.description = try container.decode(String.self, forKey: .description)
        } else {
            self.description = ""
        }
    }
}
