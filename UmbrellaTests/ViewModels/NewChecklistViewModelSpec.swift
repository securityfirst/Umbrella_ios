//
//  NewChecklistViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 14/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class NewChecklistViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("NewChecklistViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new NewChecklistViewModel") {
                let viewModel = NewChecklistViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
