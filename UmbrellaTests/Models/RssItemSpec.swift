//
//  RssItemSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 02/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class RssItemSpec: QuickSpec {
    
    override func spec() {
        describe("RssItem") {
            
            beforeEach {
                
            }
            
            it("should create a new RssItem") {
                let object = RssItem()
                expect(object).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
