//
//  FavouriteSegmentSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 02/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FavouriteSegmentSpec: QuickSpec {
    
    override func spec() {
        describe("FavouriteSegment") {
            
            beforeEach {
                
            }
            
            it("should create a new FavouriteSegment") {
                let object = FavouriteSegment()
                expect(object).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
