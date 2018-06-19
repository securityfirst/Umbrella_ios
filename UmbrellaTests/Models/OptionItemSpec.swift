//
//  OptionItemSpec.swift
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

class OptionItemSpec: QuickSpec {
    
    override func spec() {
        
        var yml = ""
        
        describe("OptionItem") {
            
            beforeEach {
                let inputFileReader = InputFileReader()
                
                guard let string = try? inputFileReader.readFileAt("f_digital-security-incident.yml") else {
                    return
                }
                
                yml = string
            }
            
            it("should create a new OptionItem") {
                let optionItem = OptionItem()
                expect(optionItem).toNot(beNil())
            }
            
            it("should create a new OptionItem with parameters") {
                let optionItem = OptionItem(label: "Outside access to data", value: "Outside access to data")
                expect(optionItem).toNot(beNil())
            }
            
            it("should create a new OptionItem with yml valid") {
                do {
                    let form = try YAMLDecoder().decode(Form.self, from: yml)
                    
                    let screen = form.screens[2]
                    let itemForm = screen.items.first
                    let optionItem = itemForm?.options.first
                    expect(itemForm?.options.count).to(equal(14))
                    expect(optionItem?.label).to(equal("Outside access to data"))
                    expect(optionItem?.value).to(equal("Outside access to data"))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
