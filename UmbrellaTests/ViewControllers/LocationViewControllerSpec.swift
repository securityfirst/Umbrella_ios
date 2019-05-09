//
//  LocationViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class LocationViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: LocationViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Feed",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("LocationViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(LocationViewController.self), timeout: 5.5, pollInterval: 0.2)
                }
            }
        }
    }
}
