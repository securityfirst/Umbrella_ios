//
//  LanguageSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class LanguageSpec: QuickSpec {
    
    override func spec() {
        describe("Language") {
            
            beforeEach {
                
            }
            
            it("should create a new Language") {
                let language = Language(name: "en")
                expect(language).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
