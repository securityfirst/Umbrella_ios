//
//  ScreenSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ScreenSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("Screen") {
            it("should create a new Screen") {
                let screen = Screen()
                expect(screen).toNot(beNil())
            }
        }
        
        afterEach {
            
        }
    }
}
