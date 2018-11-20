//
//  SettingsViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 19/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class SettingsViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("SettingsViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new SettingsViewModel") {
                let viewModel = SettingsViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
