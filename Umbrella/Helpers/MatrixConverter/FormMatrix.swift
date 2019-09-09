//
//  FormMatrix.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/08/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation
import UIKit

struct FormMatrix: MatrixConverterProtocol {
    
    var matrixFile: MatrixFile
    var isUserLogged: Bool
    var form: Form?
    var formAnswer: FormAnswer?
    var formAnswerId: Int = -1
    var matrixConverterViewModel: MatrixConverterViewModel!
    
    init(matrixFile: MatrixFile, isUserLogged: Bool) {
        self.matrixFile = matrixFile
        self.isUserLogged = isUserLogged
        self.matrixConverterViewModel = MatrixConverterViewModel()
    }
    
    mutating func updateDB() {
        print("Form UpdateDB")
        
        let forms = UmbrellaDatabase.umbrellaStatic.forms
        let languages = UmbrellaDatabase.languagesStatic
        
//        //Language
//        let languageDB = languages.filter { $0.name == matrixFile.language }.first
        
        //FormDB complete
        let formDB = forms.filter { $0.name == matrixFile.name }.first
        self.form = formDB
        
        //FormMatrix with answers
        let formMatrixFile = (matrixFile.object as? Form)!
        
        //List of form answers
        let formAnswers = matrixConverterViewModel.listFormAnswer(byFormId: formDB?.id ?? -1)
        
        var setIds = Set<Int>()
        getFormAnswerID(formMatrixFile, formAnswers, &setIds, formDB)
        
        if setIds.count > 0 {
            self.formAnswerId = setIds.first!
        }
        
//        if isUserLogged {
//            if self.formAnswerId == -1 {
//                insertAnswerDB(formMatrixFile, formDB)
//                print(self.formAnswer)
//            }
//            return
//        }
        
        // check if the form exist on database
        
        // update or insert
        if self.formAnswerId == -1 {
            insertAnswerDB(formMatrixFile, formDB)
            print(self.formAnswer)
        }
        
    }
    
    func openFile() {
        print("Form Open File")
        
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        if appDelegate.window?.rootViewController is UITabBarController {
            let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
            tabBarController.selectedIndex = 1
            if tabBarController.selectedViewController is UINavigationController {
                let navigationController = (tabBarController.selectedViewController as? UINavigationController)!
                navigationController.popViewController(animated: true)
                if navigationController.topViewController is FormViewController {
                    let storyboard = UIStoryboard(name: "Form", bundle: Bundle.main)
                    let viewcontroller = (storyboard.instantiateViewController(withIdentifier: "FillFormViewController") as? FillFormViewController)!
                    viewcontroller.fillFormViewModel.form = form!
                    viewcontroller.fillFormViewModel.formAnswer = self.formAnswer!
                    viewcontroller.isNewForm = false
                    
                    let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                    if appDelegate.window?.rootViewController is UITabBarController {
                        let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
                        if tabBarController.selectedViewController is UINavigationController {
                            let navigationController = (tabBarController.selectedViewController as? UINavigationController)!
                            navigationController.pushViewController(viewcontroller, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    //
    // MARK: - Private functions
    
    fileprivate mutating func getFormAnswerID(_ formMatrixFile: Form, _ formAnswers: [FormAnswer], _ setIds: inout Set<Int>, _ formDB: Form?) {
        for screen in formMatrixFile.screens {
            for item in screen.items {
                if item.answer.count > 0 {
                    let formAnswer = formAnswers.filter { $0.text == item.answer }.first
                    setIds.insert(formAnswer?.formAnswerId ?? -1)
                    self.formAnswer = formAnswer
                }
                
                for option in item.options where option.answer != 0 {
                    var optionId = -1
                    formDB?.screens.forEach({ (screen) in
                        screen.items.forEach({ (item) in
                            
                            if let dd = (item.options.filter { $0.label == option.label }.first) {
                                optionId = dd.id
                            }
                        })
                    })
                    
                    let formAnswer = formAnswers.filter { $0.choice == optionId }.first
                    setIds.insert(formAnswer?.formAnswerId ?? -1)
                    self.formAnswer = formAnswer
                }
            }
        }
    }
    
    fileprivate mutating func insertAnswerDB(_ formMatrixFile: Form, _ formDB: Form?) {
        self.formAnswerId = matrixConverterViewModel.lastFormAnswerId() + 1
        
        for screen in formMatrixFile.screens {
            for item in screen.items {
                if item.answer.count > 0 {
                    formDB?.screens.forEach({ (screen) in
                        if let itemFilter = (screen.items.filter { $0.name == item.name }.first) {
                            print(itemFilter.id)
                            let formAnswer = FormAnswer(formAnswerId: formAnswerId, formId: formDB?.id ?? -1, itemFormId: itemFilter.id, optionItemId: -1, text: item.answer, choice: -1)
                            let id = matrixConverterViewModel.insertFormAnswer(formAnswer: formAnswer)
                            formAnswer.id = Int(id)
                            self.formAnswer = formAnswer
                        }
                    })
                }
                
                for option in item.options where option.answer != 0 {
                    var optionId = -1
                    formDB?.screens.forEach({ (screen) in
                        screen.items.forEach({ (item) in
                            if let optionFilter = (item.options.filter { $0.label == option.label }.first) {
                                optionId = optionFilter.id
                                print(optionId)
                                let formAnswer = FormAnswer(formAnswerId: formAnswerId, formId: formDB?.id ?? -1, itemFormId: item.id, optionItemId: optionId, text: "", choice: optionId)
                                let id = matrixConverterViewModel.insertFormAnswer(formAnswer: formAnswer)
                                formAnswer.id = Int(id)
                                self.formAnswer = formAnswer
                            }
                        })
                    })
                }
            }
        }
    }
}
