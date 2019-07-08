//
//  UmbrellaMediaRouter.swift
//  Umbrella
//
//  Created by Lucas Correa on 04/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

enum UmbrellaMediaRouter: Router {
    case upload(accessToken: String, filename: String)
    case download(uri: String)
}

extension UmbrellaMediaRouter {
    
    var method: String {
        switch self {
        case .upload:
            return "POST"
        case .download:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .upload(let accessToken, let filename):
            return "upload?access_token=\(accessToken)&filename=\(filename)"
        case .download(let uri):
            return "download/comms.secfirst.org/\(uri)"
            
        }
    }
    
    var headers: [String: String] {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .upload:
            return nil
        case .download:
            return nil
        }
    }
    
    var url: URL {
        switch self {
        case .upload, .download:
            return URL(string: "\(Matrix.baseUrlString)media/r0/\(path)")!
        }
    }
}
