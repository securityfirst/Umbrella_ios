//
//  SearchUser.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

// MARK: - SearchUser
struct SearchUser: Codable {
    let users: [UserChunk]
    
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}

// MARK: - Result
struct UserChunk: Codable {
    let userID, displayName: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case displayName = "display_name"
    }
}
