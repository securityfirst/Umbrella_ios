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
    static let gitBaseURL: URL = URL(string: "https://github.com/securityfirst/umbrella-content")!
    //    static var gitBaseURL: URL = URL(string: "https://github.com/klaidliadon/umbrella-content")!
    //    static var gitBaseURL: URL = URL(string: "https://github.com/lucascorrea/umbrella-content")!
    
    //Test the GitManager
    static var debug: Bool = false
}

enum Database {
    static let name: String = "database.db"
    static var password: String = "umbrella"
}

enum RSS {
    static let feeds = [
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
    static let colors: [UIColor] = [#colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1), #colorLiteral(red: 0.9661672711, green: 0.7777593136, blue: 0.215906769, alpha: 1), #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)]
}

enum Sources {
    static let list = [
        (name: "ReliefWeb / United Nations", code: 0),
        //        (name: "United Nations", code: 1),
        (name: "UK Foreign Office Country Warnings", code: 2),
        (name: "Centres for Disease Control (CDC)", code: 3),
        (name: "Global Disaster and Alert Coordination System", code: 4),
        (name: "US State Department Country Warnings", code: 5)
    ]
}

enum Feed {
    static let feedUrl = "https://api.secfirst.org/v3/feed?country=%@&sources=%@&since=0"
}

enum Matrix {
    static let baseUrlString = "https://comms.secfirst.org/_matrix/"
}

struct Constants {
    static let TEXT_FIELD_HSPACE: CGFloat = 6.0
    static let MINIMUM_TEXTFIELD_WIDTH: CGFloat = 56.0
    static let STANDARD_ROW_HEIGHT: CGFloat = 25.0
}
