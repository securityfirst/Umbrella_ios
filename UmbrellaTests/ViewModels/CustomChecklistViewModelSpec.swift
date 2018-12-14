//
//  CustomChecklistViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 14/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CustomChecklistViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("CustomChecklistViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new CustomChecklistViewModel") {
                let viewModel = CustomChecklistViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
