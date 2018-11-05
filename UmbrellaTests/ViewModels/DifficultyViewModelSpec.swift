//
//  DifficultyViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class DifficultyViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("DifficultyViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new DifficultyViewModel") {
                let viewModel = DifficultyViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
