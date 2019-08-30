//
//  Data+Ext.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/08/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

extension Data {
    func decoded<T: Decodable>() throws -> T {
        return try JSONDecoder().decode(T.self, from: self)
    }
}
