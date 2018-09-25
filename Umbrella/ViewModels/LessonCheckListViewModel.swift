//
//  LessonCheckListViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class LessonCheckListViewModel {
    
    //
    // MARK: - Properties
    var checkList: CheckList?
    var category: Category?
    
    //
    // MARK: - Init
    init() {
        self.category = nil
        self.checkList = nil
    }
}
