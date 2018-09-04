//
//  DetailRssViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 04/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class DetailRssViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("DetailRssViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new DetailRssViewModel") {
                let viewModel = DetailRssViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
