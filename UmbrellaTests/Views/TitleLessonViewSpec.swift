//
//  TitleLessonViewSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 02/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class TitleLessonViewSpec: QuickSpec {
    
    override func spec() {
        describe("TitleLessonView") {
            
            beforeEach {
                
            }
            
            it("should create a new TitleLessonView") {
                let cell = TitleLessonView()
                expect(cell).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
