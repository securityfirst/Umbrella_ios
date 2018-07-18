//
//  AccountViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 18/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class AccountViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: AccountViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Account",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("AccountViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(AccountViewController.self))
                }
            }
        }
    }
}
