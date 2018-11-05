//
//  DifficultyViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class DifficultyViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: DifficultyViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Lesson",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "DifficultyViewController") as? DifficultyViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("DifficultyViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(DifficultyViewController.self))
                }
            }
        }
    }
}
