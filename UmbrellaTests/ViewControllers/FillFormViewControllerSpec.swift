//
//  FillFormViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 18/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FillFormViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: FillFormViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Form",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "FillFormViewController") as? FillFormViewController
            let optionItem = OptionItem(label: "label1", value: "value1")
            let itemForm = ItemForm(name: "ItemForm1", type: "type1", label: "label1", hint: "hint1", options: [optionItem])
            let screen = Screen(name: "Screen1", items: [itemForm])
            let form = Form(screens: [screen])
            form.name = "Form1"
            viewController.fillFormViewModel.form = form
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false)
            viewController.endAppearanceTransition()
        }
        
        describe("FillFormViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(FillFormViewController.self))
                }
            }
            
            describe(".viewDidAppear") {
                it ("should be presented") {
                    window.rootViewController?.viewDidAppear(true)
                    expect(window.rootViewController).toEventually(beAnInstanceOf(FillFormViewController.self))
                }
            }
        }
    }
}
