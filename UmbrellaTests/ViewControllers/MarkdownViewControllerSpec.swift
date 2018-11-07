//
//  MarkdownViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class MarkdownViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: MarkdownViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Lesson",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "MarkdownViewController") as? MarkdownViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
            
            let markdownViewModel = MarkdownViewModel()
            markdownViewModel.segment = Segment(name: "Segment test", index: 1.0, content: "## Title")
            viewController.markdownViewModel = markdownViewModel
        }
        
        describe("MarkdownViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(MarkdownViewController.self))
                }
            }
            
            describe(".methods") {
                it ("should load the markdown content") {
                    viewController.loadMarkdown()
                    expect(viewController.isLoading).to(equal(true))
                }
            }
        }
    }
}
