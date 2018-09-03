//
//  CardRssCellSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CardRssCellSpec: QuickSpec {
    
    override func spec() {
        describe("CardRssCell") {
            
            beforeEach {
                
            }
            
            it("should create a new CardRssCell") {
                let cell = CardRssCell()
                expect(cell).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
