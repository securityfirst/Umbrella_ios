//
//  TableProtocol.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

protocol TableProtocol {
    static var table: String { get }
    var tableName: String { get }
    func columns() -> [Column]
}
