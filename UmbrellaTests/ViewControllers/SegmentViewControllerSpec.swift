//
//  SegmentViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import Umbrella

class SegmentViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: SegmentViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Lesson",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "SegmentViewController") as? SegmentViewController
            
            window.makeKeyAndVisible()
            
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
            
            let segmentViewModel = SegmentViewModel()
            
            let difficulties = [Category(name: "Tools", description: "Description", index: 0),
                                Category(name: "Tools", description: "Description", index: 0)]
            
            segmentViewModel.difficulties = difficulties
            viewController.segmentViewModel = segmentViewModel
        }
        
        describe("SegmentViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    let navigationController: UINavigationController = (window.rootViewController as? UINavigationController)!
                   let segmentViewController = navigationController.viewControllers.first
                    segmentViewController?.viewDidLoad()
                    expect(segmentViewController).toEventually(beAnInstanceOf(SegmentViewController.self), timeout: 5.5, pollInterval: 0.2)
                }
            }
        }
    }
}
