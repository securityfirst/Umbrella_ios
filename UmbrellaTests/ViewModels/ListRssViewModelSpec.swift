//
//  ListRssViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ListRssViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("ListRssViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new ListRssViewModel") {
                let viewModel = ListRssViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
