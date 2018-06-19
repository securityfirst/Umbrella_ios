//
//  ItemFormSpec.swift
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

class ItemFormSpec: QuickSpec {
    
    override func spec() {
        
        var yml = ""
        var ymlInvalid = ""
        
        describe("ItemForm") {
            
            beforeEach {
                let inputFileReader = InputFileReader()
                
                guard let string = try? inputFileReader.readFileAt("f_digital-security-incident.yml") else {
                    return
                }
                
                guard let stringInvalid = try? inputFileReader.readFileAt("f_digital-security-incident-item-form-invalid.yml") else {
                    return
                }
                
                yml = string
                ymlInvalid = stringInvalid
            }
            
            it("should create a new ItemForm") {
                let itemForm = ItemForm()
                expect(itemForm).toNot(beNil())
            }
            
            it("should create a new ItemForm with parameters") {
                let itemForm = ItemForm(name: "name", type: "text_input", label: "Name:", hint: "", options: [])
                expect(itemForm).toNot(beNil())
            }
            
            it("should try to create a new ItemForm with yml invalid") {
                do {
                    
                    _ = try YAMLDecoder().decode(Form.self, from: ymlInvalid)
                } catch {
                    expect(error).toNot(beNil())
                }
            }
            
            it("should create a new ItemForm with yml valid") {
                do {
                    let form = try YAMLDecoder().decode(Form.self, from: yml)
                    
                    let itemForm = form.screens.first?.items.first
                    expect(form.screens.first?.items.count).to(equal(5))
                    expect(itemForm?.name).to(equal("name"))
                    expect(itemForm?.type).to(equal("text_input"))
                    expect(itemForm?.label).to(equal("Name:"))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
