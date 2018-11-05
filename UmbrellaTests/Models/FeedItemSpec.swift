//
//  FeedItemSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FeedItemSpec: QuickSpec {
    
    override func spec() {
        describe("FeedItem") {
            
            beforeEach {
                
            }
            
            it("should create a new FeedItem") {
                let object = FeedItem()
                expect(object).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
