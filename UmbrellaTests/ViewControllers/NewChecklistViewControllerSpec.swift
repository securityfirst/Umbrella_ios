//
//  NewChecklistViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 14/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class NewChecklistViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: NewChecklistViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Checklist",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "NewChecklistViewController") as? NewChecklistViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("NewChecklistViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(NewChecklistViewController.self))
                }
            }
        }
    }
}
