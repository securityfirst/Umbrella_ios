//
//  File+Ext.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files

enum FileType {
    case category
    case checkList
    case segment
    case form
    case none
}

extension File {
    var type: FileType {

        if self.name == ".category.yml" {
            return .category
        }
        
        if self.name.prefix(2).contains("c_") {
            return .checkList
        }
        
        if self.name.prefix(2).contains("s_") {
            return .segment
        }
        
        if self.name.prefix(2).contains("f_") {
            return .form
        }
        
        return .none
    }
}
