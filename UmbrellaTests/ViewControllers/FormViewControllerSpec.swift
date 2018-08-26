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
            
            form.id = 1
            form.name = "Form1"
            forms.append(form)
            
            let formAnswer = FormAnswer(formAnswerId: 1, formId: 1, itemFormId: 1, optionItemId: -1, text: "Test text_input", choice: -1)
            umbrella = Umbrella(languages: [], forms: forms, formAnswers: [formAnswer])
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
                
                it ("should configure a cell") {
                    viewController.loadViewIfNeeded()
                    viewController.formViewModel.umbrella = umbrella!
                    viewController.formViewModel.umbrella.formAnswers = []
                    viewController.formTableView.reloadData()
                    let cell = viewController.tableView(viewController.formTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FormCell
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    cell?.configure(withViewModel: viewController.formViewModel, indexPath: indexPath)
                    expect(cell?.titleLabel.text).to(equal("Form1"))
                }
                
                it ("should get the first cell with data Form1") {
                    viewController.loadViewIfNeeded()
                    viewController.formViewModel.umbrella = umbrella!
                    viewController.formViewModel.umbrella.formAnswers = []
                    viewController.formTableView.reloadData()
                    let cell = viewController.tableView(viewController.formTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FormCell
                    expect(cell?.titleLabel.text).to(equal("Form1"))
                }
                
                it ("should get the first cell with data Form1 to when it has a FormAnswer") {
                    viewController.loadViewIfNeeded()
                    viewController.formViewModel.umbrella = umbrella!
                    viewController.formTableView.reloadData()
                    let cell = viewController.tableView(viewController.formTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FormCell
                    expect(cell?.titleLabel.text).to(equal("Form1"))
                }
            }
            
            describe("ShareHtml") {
                it ("should be a URL to the File.html") {
                    viewController.loadViewIfNeeded()
                    viewController.formViewModel.umbrella = umbrella!
                    viewController.formTableView.reloadData()
                    
                    let url = viewController.shareHtml(indexPath: IndexPath(row: 0, section: 0))
                    
                    expect(url).toNot(beNil())
                }
            }
            
            describe("LoadFormActive") {
                it ("should be zero formAnswer") {
                    viewController.loadViewIfNeeded()
                    
                    viewController.loadFormActive()
                    
                    expect(viewController.formViewModel.umbrella.formAnswers.count).to(equal(0))
                }
            }
        }
    }
}
