//
//  SettingLocationViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 22/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class SettingLocationViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: SettingLocationViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Account",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "SettingLocationViewController") as? SettingLocationViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("SettingLocationViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(SettingLocationViewController.self), timeout: 5.5, pollInterval: 0.2)
                }
            }
        }
    }
}
