//
//  DifficultyViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class DifficultyViewModel {
    
    //
    // MARK: - Properties
    var categoryParent: Category?
    var difficulties: [Category] = [Category]()
    
    //
    // MARK: - Init
    init() {
        categoryParent = nil
    }
}
