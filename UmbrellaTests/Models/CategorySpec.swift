//
//  CategorySpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CategorySpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("Category") {
            it("should create a new Category") {
                let category = Category()
                expect(category).toNot(beNil())
            }
            
            it("should create a new Category with parameters") {
                let category = Category(name: "Tools", index: 0)
                expect(category).toNot(beNil())
            }
        }
        
        afterEach {
            
        }
    }
}
