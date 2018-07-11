//
//  FormViewControllerSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 10/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FormViewControllerSpec: QuickSpec {
    
    override func spec() {
        var viewController: FormViewController!
        let window = UIWindow(frame: UIScreen.main.bounds)
        var umbrella: Umbrella?
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Form",
                                          bundle: Bundle.main)
            viewController = storyboard.instantiateViewController(withIdentifier: "FormViewController") as? FormViewController
            
            window.makeKeyAndVisible()
            window.rootViewController = viewController
            viewController.beginAppearanceTransition(true, animated: false) 
            viewController.endAppearanceTransition()
        
            var forms = [Form]()
            let optionItem = OptionItem(label: "label1", value: "value1")
            let itemForm = ItemForm(name: "ItemForm1", type: "type1", label: "label1", hint: "hint1", options: [optionItem])
            let screen = Screen(name: "Screen1", items: [itemForm])
            let form = Form(screens: [screen])
            form.name = "Form1"
            forms.append(form)
            umbrella = Umbrella(languages: [], forms: forms)
        }
        
        describe("FormViewController") {
            describe(".viewDidLoad") {
                it ("should be presented") {
                    window.rootViewController?.viewDidLoad()
                    expect(window.rootViewController).toEventually(beAnInstanceOf(FormViewController.self))
                }
            }
            
            describe("tableview") {
                it ("should be a cell valid") {
                    viewController.loadViewIfNeeded()
                    let cell = viewController.formTableView.dequeueReusableCell(withIdentifier: "FormCell")
                    expect(cell).toNot(beNil())
                }
                
                it ("should be a cell inValid") {
                    viewController.loadViewIfNeeded()
                    let cell = viewController.formTableView.dequeueReusableCell(withIdentifier: "Cell")
                    expect(cell).to(beNil())
                }
                
                it ("should get the first cell with data Form1") {
                    viewController.loadViewIfNeeded()
                    viewController.formViewModel.umbrella = umbrella!
                    let cell = viewController.tableView(viewController.formTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FormCell
                    expect(cell?.titleLabel.text).to(equal("Form1"))
                }
            }
        }
    }
}
