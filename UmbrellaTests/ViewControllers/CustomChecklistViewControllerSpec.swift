//
//  CustomChecklistViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 14/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CustomChecklistViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: CustomChecklistViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Checklist",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "CustomChecklistViewController") as? CustomChecklistViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("CustomChecklistViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(CustomChecklistViewController.self))
                }
            }
        }
    }
}
