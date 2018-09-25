//
//  CategorySpec.swift
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

class CategorySpec: QuickSpec {
    
    override func spec() {
        
        describe("Category") {
            
            beforeEach {
                
            }
            
            it("should create a new Category") {
                let category = Category()
                expect(category).toNot(beNil())
            }
            
            it("should create a new Category with parameters") {
                let category = Category(name: "Tools", description: "Description", index: 0)
                expect(category).toNot(beNil())
                expect(category.name).to(equal("Tools"))
                expect(category.index).to(equal(0))
            }
            
            it("should create a new Category with yml invalid") {
                do {
                    
                    let yml = """
                                {}
                              """
                    let category = try YAMLDecoder().decode(Category.self, from: yml)
                    
                    expect(category.name).to(equal(""))
                    expect(category.index).to(equal(0))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            it("should create a new Category with yml valid") {
                do {
                    
                    let yml = """
                                index: 2
                                title: Communications
                                icon: test.png
                              """
                    let category = try YAMLDecoder().decode(Category.self, from: yml)
                    
                    expect(category.name).to(equal("Communications"))
                    expect(category.index).to(equal(2))
                } catch {
                    expect(error).to(beNil())
                }
            }
            
            it("should try to create a new Category with index invalid") {
                do {
                    
                    let yml = """
                                index: test
                                title: Communications
                                icon: test.png
                              """
                    _ = try YAMLDecoder().decode(Category.self, from: yml)
                } catch {
                    print("\(error.localizedDescription)")
                    expect(error.localizedDescription).to(equal("The data couldn’t be read because it isn’t in the correct format."))
                }
            }
            
            it("should create a new Category and return columns") {
                let category = Category(name: "Tools", description: "Description", index: 0)
                expect(category.columns()).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
