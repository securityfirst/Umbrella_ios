//
//  GlobalSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class GlobalSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("Global") {
            it("should wait for 2 seconds") {
                let dateFormatter = Global.dateFormatter
                dateFormatter.dateFormat = "mmss"
                
                let seconds = dateFormatter.string(from: Date())
                waitUntil(timeout: 4) { done in
                    delay(2) {
                        let seconds2 = dateFormatter.string(from:Date())
                        expect(Int(seconds2)).to(equal(Int(seconds)!+2))
                        done()
                    }
                }
            }
        }
        
        afterEach {
            
        }
    }
}
