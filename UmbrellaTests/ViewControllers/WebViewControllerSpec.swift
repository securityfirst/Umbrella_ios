//
//  WebViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class WebViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: WebViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Feed",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("WebViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(WebViewController.self), timeout: 5.5, pollInterval: 0.2)
                }
            }
        }
    }
}
