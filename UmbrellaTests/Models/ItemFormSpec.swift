//
//  ItemFormSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ItemFormSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("ItemForm") {
            it("should create a new ItemForm") {
                let itemForm = ItemForm()
                expect(itemForm).toNot(beNil())
            }
        }
        
        afterEach {
            
        }
    }
}
