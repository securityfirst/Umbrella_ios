//
//  CheckItemSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CheckItemSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("CheckItem") {
            it("should create a new CheckItem") {
                let checkItem = CheckItem()
                expect(checkItem).toNot(beNil())
            }
        }
        
        afterEach {
            
        }
    }
}
