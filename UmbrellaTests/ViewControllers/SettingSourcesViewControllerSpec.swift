//
//  SettingSourcesViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 21/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class SettingSourcesViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: SettingSourcesViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Account",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "SettingSourcesViewController") as? SettingSourcesViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("SettingSourcesViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(SettingSourcesViewController.self))
                }
            }
        }
    }
}
