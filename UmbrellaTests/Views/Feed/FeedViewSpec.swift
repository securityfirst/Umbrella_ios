//
//  FeedViewSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 04/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FeedViewSpec: QuickSpec {
    
    override func spec() {
        
        var viewController: FeedViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Feed",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("FeedView") {
            it("should create a new FeedView") {
                let view = FeedView()
                expect(view).toNot(beNil())
            }
        }
        
        describe("tableview") {
            it ("should be a cell valid") {
                viewController.loadViewIfNeeded()
                let cell = viewController.feedView.feedTableView.dequeueReusableCell(withIdentifier: "FeedCell")
                expect(cell).toNot(beNil())
            }
            
            it ("should be a cell inValid") {
                viewController.loadViewIfNeeded()
                let cell = viewController.feedView.feedTableView.dequeueReusableCell(withIdentifier: "Cell")
                expect(cell).to(beNil())
            }
        }
        afterEach {
            
        }
    }
}
