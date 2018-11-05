//
//  LessonCheckListViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class LessonCheckListViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("LessonCheckListViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new LessonCheckListViewModel") {
                let viewModel = LessonCheckListViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
