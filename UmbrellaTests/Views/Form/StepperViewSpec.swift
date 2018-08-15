//
//  StepperViewSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 17/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import Umbrella

class StepperViewSpec: QuickSpec {
    
    override func spec() {
        
        var viewController: FillFormViewController!
        let stepperView = StepperView(frame: CGRect(x: 0, y: 0, width: 300, height: 70))
        
        describe("StepperView") {
            
            beforeEach {
                let storyboard = UIStoryboard(name: "Form",
                                              bundle: Bundle.main)
                viewController = storyboard.instantiateViewController(withIdentifier: "FillFormViewController") as? FillFormViewController
                let optionItem = OptionItem(label: "label1", value: "value1")
                let itemForm = ItemForm(name: "ItemForm1", type: "type1", label: "label1", hint: "hint1", options: [optionItem])
                let screen1 = Screen(name: "Screen1", items: [itemForm])
                let screen2 = Screen(name: "Screen2", items: [itemForm])
                let form = Form(screens: [screen1, screen2])
                form.name = "Form1"
                viewController.fillFormViewModel.form = form
            }
            
            it("should create a StepperView") {
                
                expect(stepperView).toNot(beNil())
            }
            
            it("should reload the data of the StepperView") {
                viewController.stepperView = stepperView
                viewController.stepperView.dataSource = viewController
                viewController.stepperView.reloadData()
                
                expect(stepperView.totalViewCount).to(equal(2))
            }
            
            it("should change the stage of a titleView") {
                viewController.stepperView = stepperView
                viewController.stepperView.dataSource = viewController
                viewController.stepperView.reloadData()
                expect(stepperView.currentIndex).to(equal(0))
                viewController.stepperView.scrollViewDidPage(page: 1)
                expect(stepperView.currentIndex).to(equal(1))
            }
            
            afterEach {
                
            }
        }
    }
}
