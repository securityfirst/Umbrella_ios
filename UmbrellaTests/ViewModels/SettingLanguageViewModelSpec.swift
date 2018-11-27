//
//  SettingLanguageViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 26/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class SettingLanguageViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("SettingLanguageViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new SettingLanguageViewModel") {
                let viewModel = SettingLanguageViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
