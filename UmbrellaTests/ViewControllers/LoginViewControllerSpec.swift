//
//  LoginViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 19/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class LoginViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: LoginViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Account",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("LoginViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(LoginViewController.self))
                }
            }
        }
    }
}
