//
//  CheckListSpec.swift
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

class CheckListSpec: QuickSpec {
    
    override func spec() {
        
        var yml = ""
        
        describe("CheckList") {
            
            beforeEach {
                yml = """
                index: 100
                list:
                - check: Avoid regular phone calls for sensitive conversations
                - check: Use Signal for secure calls
                - label: If you must use less secure options
                - check: Download from official website
                """
            }
            
            it("should create a new CheckList") {
                let checkList = CheckList()
                expect(checkList).toNot(beNil())
            }
            
            it("should create a new CheckList with parameters") {
                let checkList = CheckList(index: 3, items: [])
                expect(checkList).toNot(beNil())
                expect(checkList.index).to(equal(3))
                expect(checkList.items.count).to(equal(0))
            }
            
            it("should try to create a new CheckList with yml invalid") {
                do {
                    
                    let ymlInvalid = """
                                {}
                              """
                    let checkList = try YAMLDecoder().decode(CheckList.self, from: ymlInvalid)
                    
                    expect(checkList.index).to(equal(0))
                    expect(checkList.items.count).to(equal(0))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            it("should create a new CheckList with yml valid") {
                do {
                    let checkList = try YAMLDecoder().decode(CheckList.self, from: yml)
                    
                    expect(checkList.index).to(equal(100))
                    expect(checkList.items.count).to(equal(4))
                    expect(checkList.items[2].isChecked).to(equal(true))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
