//
//  SegmentSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class SegmentSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("Segment") {
            it("should create a new Segment") {
                let segment = Segment()
                expect(segment).toNot(beNil())
            }
        }
        
        afterEach {
            
        }
    }
}
