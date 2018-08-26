//
//  DynamicFormSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 20/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class DynamicFormSpec: QuickSpec {
    
    var viewController: UIViewController!
    let window = UIWindow(frame: UIScreen.main.bounds)
    var form: Form!
    
    override func spec() {
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Form",
                                          bundle: Bundle.main)
            self.viewController = storyboard.instantiateViewController(withIdentifier: "DynamicViewController")
            let optionItem = OptionItem(label: "label1", value: "value1")
            let itemForm = ItemForm(name: "ItemForm1", type: "type1", label: "label1", hint: "hint1", options: [optionItem])
            let screen = Screen(name: "Screen1", items: [itemForm])
            self.form = Form(screens: [screen])
            self.form.name = "Form1"
            
            self.window.makeKeyAndVisible()
            self.window.rootViewController = self.viewController
            self.viewController.beginAppearanceTransition(true, animated: false)
            self.viewController.endAppearanceTransition()
        }
        
        describe("DynamicForm") {
            
            it("should create a DynamicForm") {
                let dynamicForm = (self.viewController.view as? DynamicFormView)!
                dynamicForm.tag = 1
                dynamicForm.dynamicFormViewModel.screen = self.form.screens.first!
                dynamicForm.setTitle(title: dynamicForm.dynamicFormViewModel.screen.name)
                
                expect(dynamicForm).toNot(beNil())
            }
            
            describe("tableview") {
                it ("should configure a cell of TextField") {
                    self.viewController.loadViewIfNeeded()
                    let dynamicForm = (self.viewController.view as? DynamicFormView)!
                    let cell = dynamicForm.dynamicTableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as? TextFieldCell
                    expect(cell).toNot(beNil())
                    
                    dynamicForm.dynamicFormViewModel.screen = self.form.screens.first!
                    dynamicForm.setTitle(title: dynamicForm.dynamicFormViewModel.screen.name)
                    
                    cell?.configure(withViewModel: dynamicForm.dynamicFormViewModel, indexPath: IndexPath(row: 0, section: 0))
                    expect(cell?.valueText).toNot(beNil())
                }
                
                it ("should configure a cell of TextArea") {
                    self.viewController.loadViewIfNeeded()
                    let dynamicForm = (self.viewController.view as? DynamicFormView)!
                    let cell = dynamicForm.dynamicTableView.dequeueReusableCell(withIdentifier: "TextAreaCell") as? TextAreaCell
                    expect(cell).toNot(beNil())
                    
                    dynamicForm.dynamicFormViewModel.screen = self.form.screens.first!
                    dynamicForm.setTitle(title: dynamicForm.dynamicFormViewModel.screen.name)
                    
                    cell?.configure(withViewModel: dynamicForm.dynamicFormViewModel, indexPath: IndexPath(row: 0, section: 0))
                    expect(cell?.textView).toNot(beNil())
                }
                
                it ("should configure a cell of MultiChoice") {
                    self.viewController.loadViewIfNeeded()
                    let dynamicForm = (self.viewController.view as? DynamicFormView)!
                    let cell = dynamicForm.dynamicTableView.dequeueReusableCell(withIdentifier: "MultiChoiceCell") as? MultiChoiceCell
                    
                    dynamicForm.dynamicFormViewModel.screen = self.form.screens.first!
                    dynamicForm.setTitle(title: dynamicForm.dynamicFormViewModel.screen.name)
                    
                    cell?.configure(withViewModel: dynamicForm.dynamicFormViewModel, indexPath: IndexPath(row: 0, section: 0))
                    expect(cell).toNot(beNil())
                }
                
                it ("should configure a cell of SingleChoice") {
                    self.viewController.loadViewIfNeeded()
                    let dynamicForm = (self.viewController.view as? DynamicFormView)!
                    let cell = dynamicForm.dynamicTableView.dequeueReusableCell(withIdentifier: "SingleChoiceCell") as? SingleChoiceCell
                    
                    dynamicForm.dynamicFormViewModel.screen = self.form.screens.first!
                    dynamicForm.setTitle(title: dynamicForm.dynamicFormViewModel.screen.name)
                    
                    cell?.configure(withViewModel: dynamicForm.dynamicFormViewModel, indexPath: IndexPath(row: 0, section: 0))
                    expect(cell).toNot(beNil())
                }
                
                it ("should be a cell inValid") {
                    self.viewController.loadViewIfNeeded()
                    let dynamicForm = (self.viewController.view as? DynamicFormView)!
                    let cell = dynamicForm.dynamicTableView.dequeueReusableCell(withIdentifier: "Cell")
                    expect(cell).to(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
