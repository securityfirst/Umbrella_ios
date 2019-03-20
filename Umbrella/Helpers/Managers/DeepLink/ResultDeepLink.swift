//
//  ResultDeepLink.swift
//  Umbrella
//
//  Created by Lucas Correa on 25/02/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct ResultDeepLink {
    
    //
    // MARK: - Properties
    let type: DeepLinkType!
    let category: String?
    let subCategory: String?
    let difficulty: String?
    let checklistId: String?
    let file: String?
    
    init(type: DeepLinkType!, file: String? = nil) {
        self.type = type
        self.category = nil
        self.subCategory = nil
        self.difficulty = nil
        self.checklistId = nil
        self.file = file
    }
    
    init(type: DeepLinkType!, category: String? = nil, subCategory: String? = nil, difficulty: String? = nil, checklistId: String? = nil) {
        self.type = type
        self.category = category
        self.subCategory = subCategory
        self.difficulty = difficulty
        self.file = nil
        self.checklistId = checklistId
    }
    
    init(type: DeepLinkType!, category: String? = nil, subCategory: String? = nil, difficulty: String? = nil, file: String? = nil) {
        self.type = type
        self.category = category
        self.subCategory = subCategory
        self.difficulty = difficulty
        self.file = file
        self.checklistId = nil
    }
}
