//
//  ReviewLessonViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 10/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class ReviewLessonViewModel {
    
    //
    // MARK: - Properties
    var segments: [Segment]?
    var checkLists: [CheckList]?
    var category: Category?
    var selected: Any!
    
    //
    // MARK: - Init
    init() {
        self.segments = nil
        self.checkLists = nil
        self.category = nil
    }
}
