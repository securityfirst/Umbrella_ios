//
//  FeedViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FeedViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("FeedViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new FeedViewModel") {
                let viewModel = FeedViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
