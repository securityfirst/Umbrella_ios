//
//  UserMatrix.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class UserMatrix: Codable, TableProtocol {
    
    var username: String
    var password: String
    var userId: String  
    var accessToken: String
    var homeServer: String
    var deviceId: String
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case password = "password"
        case userId = "user_id"
        case accessToken = "access_token"
        case homeServer = "home_server"
        case deviceId = "device_id"
    }
    
    init() {
        self.username = ""
        self.password = ""
        self.userId = ""
        self.accessToken = ""
        self.homeServer = ""
        self.deviceId = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.username) {
            self.username = try container.decode(String.self, forKey: .username)
        } else {
            self.username = ""
        }
        
        if container.contains(.password) {
            self.password = try container.decode(String.self, forKey: .password)
        } else {
            self.password = ""
        }
        
        if container.contains(.userId) {
            self.userId = try container.decode(String.self, forKey: .userId)
        } else {
            self.userId = ""
        }
        
        if container.contains(.accessToken) {
            self.accessToken = try container.decode(String.self, forKey: .accessToken)
        } else {
            self.accessToken = ""
        }
        
        if container.contains(.homeServer) {
            self.homeServer = try container.decode(String.self, forKey: .homeServer)
        } else {
            self.homeServer = ""
        }
        
        if container.contains(.deviceId) {
            self.deviceId = try container.decode(String.self, forKey: .deviceId)
        } else {
            self.deviceId = ""
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "user_matrix"
    var tableName: String {
        return UserMatrix.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "username", type: .string),
            Column(name: "password", type: .string),
            Column(name: "user_id", type: .string),
            Column(name: "access_token", type: .string),
            Column(name: "home_server", type: .string),
            Column(name: "device_id", type: .string)
        ]
        return array
    }
}
