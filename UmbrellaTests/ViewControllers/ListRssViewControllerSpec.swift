//
//  ListRssViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ListRssViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: ListRssViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Feed",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "ListRssViewController") as? ListRssViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("ListRssViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(ListRssViewController.self))
                }
            }
        }
    }
}
