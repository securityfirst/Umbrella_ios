//
//  LoadingViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 26/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class LoadingViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: LoadingViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Main",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("LoadingViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(LoadingViewController.self))
                }
            }
            describe("loadTent") {
                it("should do the clone of the tent") {
                    Config.debug = false
                    waitUntil(timeout: 600) { done in
                        viewController.loadTent(completion: {
                          expect(1.0).to(equal(1.0))
                          done()
                        })
                    }
                }
            }
        }
    }
}
