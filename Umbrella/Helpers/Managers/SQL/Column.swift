//
//  Column.swift
//  Umbrella
//
//  Created by Lucas Correa on 25/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

enum ColumnType {
    case string
    case int
    case real
    case primaryKey
    case foreignKey
}

struct Column {
    
    //
    // MARK: - Properties
    var name: String?
    var type: ColumnType?
    var foreignKey: ForeignKey?
    
    //
    // MARK: - Initializers
    init(name: String, type: ColumnType) {
        self.name = name
        self.type = type
        self.foreignKey = nil
    }
    
    init(foreignKey: ForeignKey) {
        self.type = .foreignKey
        self.foreignKey = foreignKey
    }
}
