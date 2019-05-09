//
//  FeedViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 18/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FeedViewControllerSpec: QuickSpec {
    
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
        
        describe("FeedViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(FeedViewController.self), timeout: 5.5, pollInterval: 0.2)
                }
            }
        }
    }
}
