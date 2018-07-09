//
//  HomeViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 04/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class HomeViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("HomeViewModel") {
            
            let homeViewModel = HomeViewModel()
            
            beforeEach {
                
            }
            
            it("should do the clone of tent") {
                Config.debug = false
                waitUntil(timeout: 600) { done in
                    homeViewModel.clone(witUrl: Config.gitBaseURL, completion: { progress in
                        if progress == 1.0 {
                            expect(progress).to(equal(1.0))
                            done()
                        }
                    }, failure: { error in
                        print("GitManager: \(error)")
                    })
                }
            }
            
            it("should do the parse of tent") {
                Config.debug = false
                waitUntil(timeout: 600) { done in
                    homeViewModel.parseTent(completion: { progress in
                        if progress == 1.0 {
                            expect(progress).to(equal(1.0))
                            done()
                        }
                    })
                }
            }
            
            afterEach {
                
            }
        }
    }
}
