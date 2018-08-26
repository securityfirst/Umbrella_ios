//
//  Constants.swift
//  Umbrella
//
//  Created by Lucas Correa on 23/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

enum Config {
    static var gitBaseURL = URL(string: "https://github.com/klaidliadon/umbrella-content")!
    //Test the GitManager
    static var debug: Bool = false
}

enum Database {
    static var name: String = "database.db"
    static var password: String = "umbrella"
}
