//
//  ListRssCellSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ListRssCellSpec: QuickSpec {
    
    override func spec() {
        describe("ListRssCell") {
            
            beforeEach {
                
            }
            
            it("should create a new ListRssCell") {
                let cell = ListRssCell()
                expect(cell).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
