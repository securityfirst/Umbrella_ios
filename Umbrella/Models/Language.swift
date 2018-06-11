//
//  Language.swift
//  Umbrella
//
//  Created by Lucas Correa on 06/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Language: FolderProtocol {
    let name: String
    var categories: [Category]
    var folderName: String?
    
    init(name: String) {
        self.name = name
        self.categories = []
    }
}
