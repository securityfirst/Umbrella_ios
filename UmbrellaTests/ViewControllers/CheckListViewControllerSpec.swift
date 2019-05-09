//
//  CheckListViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 18/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CheckListViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: ChecklistViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Checklist",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "ChecklistViewController") as? ChecklistViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("ChecklistViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(ChecklistViewController.self), timeout: 5.5, pollInterval: 0.2)
                }
            }
        }
    }
}
