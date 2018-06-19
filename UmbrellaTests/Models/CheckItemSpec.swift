//
//  CheckItemSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 12/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Yams

@testable import Umbrella

class CheckItemSpec: QuickSpec {
    
    override func spec() {
        
        var yml = ""
        var name = ""
        
        describe("CheckItem") {
            
            beforeEach {
                name = "Avoid regular phone calls for sensitive conversations"
                yml = """
                check: Avoid regular phone calls for sensitive conversations
                """
            }
            
            it("should create a new CheckItem") {
                let checkItem = CheckItem()
                expect(checkItem).toNot(beNil())
            }
            
            it("should create a new CheckItem with parameters") {
                let checkItem = CheckItem(name: name)
                expect(checkItem).toNot(beNil())
                expect(checkItem.name).to(equal(name))
            }
            
            it("should try to create a new CheckItem with yml invalid") {
                do {
                    
                    let ymlInvalid = """
                                {}
                              """
                    let checkItem = try YAMLDecoder().decode(CheckItem.self, from: ymlInvalid)
                    
                    expect(checkItem.name).to(equal(""))
                    expect(checkItem.isChecked).to(equal(false))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            it("should create a new CheckItem with yml valid") {
                do {
                    let checkItem = try YAMLDecoder().decode(CheckItem.self, from: yml)
                    expect(checkItem.name).to(equal(name))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
