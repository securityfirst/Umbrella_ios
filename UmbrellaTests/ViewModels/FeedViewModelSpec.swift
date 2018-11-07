//
//  FeedViewModelSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FeedViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("FeedViewModel") {
            
            beforeEach {
                
            }
            
            it("should create a new FeedViewModel") {
                let viewModel = FeedViewModel()
                expect(viewModel).toNot(beNil())
            }
            
            it("should do request to Yemen location") {
                let viewModel = FeedViewModel()
                
                viewModel.location = "ye"
                viewModel.sources = [0,1,2,3,4,5]
                waitUntil(timeout: 30) { done in
                    viewModel.requestFeed(completion: {
                        expect(viewModel.feedItems.count) > 0
                        done()
                    }, failure: { error in
                        done()
                    })
                }
                expect(viewModel).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
