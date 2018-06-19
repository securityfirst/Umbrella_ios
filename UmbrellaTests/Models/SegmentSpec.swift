//
//  SegmentSpec.swift
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

class SegmentSpec: QuickSpec {
    
    override func spec() {
        var content: String = ""
        
        describe("Segment") {
            
            beforeEach {
                content = """
                **Efail**
                
                This week, security researchers released information about vulnerabilities in PGP email clients that could expose past or future content, even if it was encrypted.
                """
            }
            
            it("should create a new Segment") {
                let segment = Segment()
                expect(segment).toNot(beNil())
            }
            
            it("should create a new Segment with parameters") {
                let segment = Segment(name: "Efail", index: 6, content: content)
                expect(segment).toNot(beNil())
                expect(segment.name).to(equal("Efail"))
                expect(segment.index).to(equal(6))
                expect(segment.content).to(equal(content))
            }
            
            it("should try to create a new Segment with yml invalid") {
                do {
                    
                    let ymlInvalid = """
                                {}
                              """
                    let segment = try YAMLDecoder().decode(Segment.self, from: ymlInvalid)
                    
                    expect(segment.name).to(equal(""))
                    expect(segment.index).to(equal(0))
                    expect(segment.content).to(equal(""))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            it("should create a new Segment with yml valid") {
                do {
                    
                    let header = """
                                index: 6
                                title: Efail
                              """
                    let segment = try YAMLDecoder().decode(Segment.self, from: header)
                    
                    expect(segment.name).to(equal("Efail"))
                    expect(segment.index).to(equal(6))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            it("should try to create a new Segment with index invalid") {
                do {
                    
                    let header = """
                                index: test
                                title: Efail
                              """
                    _ = try YAMLDecoder().decode(Segment.self, from: header)
                } catch {
                    print("\(error.localizedDescription)")
                    expect(error.localizedDescription).to(equal("The data couldn’t be read because it isn’t in the correct format."))
                }
            }
            
            afterEach {
                
            }
        }
    }
}
