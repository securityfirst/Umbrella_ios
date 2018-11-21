//
//  SettingIntervalViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 20/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class SettingIntervalViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("SettingIntervalViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new SettingIntervalViewModel") {
                let viewModel = SettingIntervalViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
