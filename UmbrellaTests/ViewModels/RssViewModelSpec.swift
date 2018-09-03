//
//  RssViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class RssViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("RssViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new RssViewModel") {
                let viewModel = RssViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
