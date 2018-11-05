//
//  ChecklistCheckedSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 02/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ChecklistCheckedSpec: QuickSpec {
    
    override func spec() {
        describe("ChecklistChecked") {
            
            beforeEach {
                
            }
            
            it("should create a new ChecklistChecked") {
                let object = ChecklistChecked()
                expect(object).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
