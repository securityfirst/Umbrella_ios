//
//  MarkdownViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class MarkdownViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("MarkdownViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new MarkdownViewModel") {
                let viewModel = MarkdownViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
