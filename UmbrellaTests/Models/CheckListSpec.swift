//
//  CheckListSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CheckListSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("CheckList") {
            it("should create a new CheckList") {
                let checkList = CheckList()
                expect(checkList).toNot(beNil())
            }
        }
        
        afterEach {
            
        }
    }
}
