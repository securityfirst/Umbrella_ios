//
//  FormSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FormSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("Form") {
            it("should create a new Form") {
                let form = Form()
                expect(form).toNot(beNil())
            }
        }
        
        afterEach {
            
        }
    }
}
