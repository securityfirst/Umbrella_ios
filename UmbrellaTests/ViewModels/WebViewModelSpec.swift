//
//  WebViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 04/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class WebViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("WebViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new WebViewModel") {
                let viewModel = WebViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
