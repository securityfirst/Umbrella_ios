//
//  Router.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

protocol Router {
    var method: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var url: URL { get }
}
