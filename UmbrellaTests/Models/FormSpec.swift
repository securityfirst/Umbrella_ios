//
//  FormSpec.swift
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

class FormSpec: QuickSpec {
    
    override func spec() {
        
        var yml = ""
        
        describe("Form") {
            
            beforeEach {
                let inputFileReader = InputFileReader()
                
                guard let string = try? inputFileReader.readFileAt("f_digital-security-incident.yml") else {
                    return
                }
                
                yml = string
            }
            
            it("should create a new Form") {
                let form = Form()
                expect(form).toNot(beNil())
            }
            
            it("should create a new Form with parameters") {
                let form = Form(screens: [])
                expect(form).toNot(beNil())
            }
            
            it("should try to create a new Form with yml invalid") {
                do {
                    
                    let ymlInvalid = """
                                {}
                              """
                    let form = try YAMLDecoder().decode(Form.self, from: ymlInvalid)
                    expect(form.screens.count).to(equal(0))
                    expect(form.name).to(equal(""))
                } catch {
                    expect(error).toNot(beNil())
                }
            }
            
            it("should create a new Form with yml valid") {
                do {
                    let form = try YAMLDecoder().decode(Form.self, from: yml)
                    expect(form.screens.count).to(equal(14))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            it("should be a name to the Form") {
                do {
                    let form = try YAMLDecoder().decode(Form.self, from: yml)
                    expect(form.name).to(equal("Digital Security Incident"))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
