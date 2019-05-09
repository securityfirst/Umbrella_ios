//
//  SettingLanguageViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 26/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class SettingLanguageViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: SettingLanguageViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Account",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "SettingLanguageViewController") as? SettingLanguageViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("SettingLanguageViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(SettingLanguageViewController.self), timeout: 5.5, pollInterval: 0.2)
                }
            }
        }
    }
}
