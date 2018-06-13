//
//  OptionItemSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class OptionItemSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("OptionItem") {
            it("should create a new OptionItem") {
                let optionItem = OptionItem()
                expect(optionItem).toNot(beNil())
            }
        }
        
        afterEach {
            
        }
    }
}
