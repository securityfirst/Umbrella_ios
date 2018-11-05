//
//  LessonViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class LessonViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("LessonViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new LessonViewModel") {
                let viewModel = LessonViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
