//
//  AskForPasswordViewSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 19/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class AskForPasswordViewSpec: QuickSpec {
    
    override func spec() {
        describe("AskForPasswordView") {
            
            beforeEach {
                
            }
            
            it("should create a new AskForPasswordView") {
                let view = AskForPasswordView()
                expect(view).toNot(beNil())
            }
            
            describe(".viewDidLoad") {
                it("should create a new AskForPasswordView") {
                    let view = AskForPasswordView()
                    view.awakeFromNib()
                    expect(view).toNot(beNil())
                }
            }
            afterEach {
                
            }
        }
    }
}
