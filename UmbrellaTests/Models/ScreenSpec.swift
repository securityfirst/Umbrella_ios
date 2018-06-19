//
//  ScreenSpec.swift
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

class ScreenSpec: QuickSpec {
    
    override func spec() {
        
        var yml = ""
        
        describe("Screen") {
            
            beforeEach {
                let inputFileReader = InputFileReader()
                
                guard let string = try? inputFileReader.readFileAt("f_digital-security-incident.yml") else {
                    return
                }
                
                yml = string
            }
            
            it("should create a new Screen") {
                let screen = Screen()
                expect(screen).toNot(beNil())
            }
            
            it("should create a new Screen with parameters") {
                let screen = Screen(name: "Digital Security Incident", items: [])
                expect(screen).toNot(beNil())
            }
            
            it("should try to create a new Screen with yml invalid") {
                do {
                    
                    let ymlInvalid = """
                                {}
                              """
                    let form = try YAMLDecoder().decode(Form.self, from: ymlInvalid)
                    expect(form.screens.count).to(equal(0))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            it("should create a new Screen with yml valid") {
                do {
                    let form = try YAMLDecoder().decode(Form.self, from: yml)
                    expect(form.screens.count).to(equal(14))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
