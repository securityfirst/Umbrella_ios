//
//  AccountViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 19/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class AccountViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("AccountViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new AccountViewModel") {
                let viewModel = AccountViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
