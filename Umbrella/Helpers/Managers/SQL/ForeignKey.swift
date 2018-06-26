//
//  ForeignKey.swift
//  Umbrella
//
//  Created by Lucas Correa on 25/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

struct ForeignKey {
    var key: String
    var table: Table
    var tableKey: String
}
