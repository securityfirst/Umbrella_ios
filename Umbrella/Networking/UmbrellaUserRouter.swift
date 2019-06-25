//
//  UmbrellaUserRouter.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

enum UmbrellaUserRouter: Router {
    case login(username: String, password: String, type: String)
    case logout(accessToken: String)
    case createUser(username: String, password: String, email: String)
    case requestEmailToken(token: String, email: String)
}

extension UmbrellaUserRouter {
    
    var method: String {
        switch self {
        case .login:
            return "POST"
        case .logout:
            return "POST"
        case .createUser:
            return "POST"
        case .requestEmailToken:
            return "POST"
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .logout(let accessToken):
            return "logout?access_token=\(accessToken)"
        case .createUser(_, _, _):
            return "register"
        case .requestEmailToken(let accessToken, _):
            return "logout?access_token=\(accessToken)"
        }
    }
    
    var headers: [String: String] {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let username , let password, let type):
            return [
                "type": type,
                "user": "@\(username):comms.secfirst.org",
                "password": password
            ]
        case .logout:
            return nil
        case .createUser(let username , let password, _):
            return [
                "auth": [
                    "type": "m.login.dummy"
                ],
                "username": username,
                "password": password
            ]
        case .requestEmailToken(_, let email):
            return [
                "email": email,
                "send_attempt": "1",
                "id_server": "vector.im",
                "client_secret": "secret"
            ]
        }
    }
    
    var url: URL {
        switch self {
        case .login:
            return URL(string: "\(Matrix.baseUrlString)\(path)")!
        case .logout:
            return URL(string: "\(Matrix.baseUrlString)\(path)")!
        case .createUser:
            return URL(string: "\(Matrix.baseUrlString)\(path)")!
        case .requestEmailToken:
            return URL(string: "\(Matrix.baseUrlString)\(path)")!
        }
    }
}
