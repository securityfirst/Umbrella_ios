//
//  InputFileReaderSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 19/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Files

@testable import Umbrella

class InputFileReaderSpec: QuickSpec {
    
    override func spec() {
        
        beforeEach {
            
        }
        
        describe("InputFileReader") {
            it("should be able to read a file") {
                let inputFileReader = InputFileReader()
                let string = try? inputFileReader.readFileAt("f_digital-security-incident.yml")
                expect(string).notTo(beNil())
            }
            
            it("should try to read a file doesnt exist") {
                let inputFileReader = InputFileReader()
                expect {
                    try inputFileReader.readFileAt("test.yml")
                    }.to(throwError(InputFileReaderError.inputFileNotFound))
                
            }
            
            it("should try to read a file with format invalid") {
                let inputFileReader = InputFileReader()
                expect {
                    try inputFileReader.readFileAt("tool_cobian1.png")
                    }.to(throwError(InputFileReaderError.invalidFileFormat))
            }
        }
        
        afterEach {
            
        }
    }
}
