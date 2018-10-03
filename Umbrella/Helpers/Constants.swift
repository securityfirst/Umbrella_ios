//
//  Constants.swift
//  Umbrella
//
//  Created by Lucas Correa on 23/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

enum Config {
//    static var gitBaseURL = URL(string: "https://github.com/securityfirst/umbrella-content")!
    static var gitBaseURL = URL(string: "https://github.com/klaidliadon/umbrella-content")!
    //Test the GitManager
    static var debug: Bool = false
}

enum Database {
    static var name: String = "database.db"
    static var password: String = "umbrella"
}

enum RSS {
    static var feeds = [
        ["url": "https://www.theguardian.com/world/rss"],
        ["url": "https://www.aljazeera.com/xml/rss/all.xml"],
        ["url": "http://rss.cnn.com/rss/edition.rss"],
        ["url": "http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk"],
        ["url": "http://feeds.feedburner.com/NakedSecurity"],
        ["url": "https://krebsonsecurity.com/feed/"],
        ["url": "https://threatpost.com/feed/"]
    ]
}

enum Lessons {
    static var colors: [UIColor] = [#colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1), #colorLiteral(red: 0.9661672711, green: 0.7777593136, blue: 0.215906769, alpha: 1), #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)]
}
