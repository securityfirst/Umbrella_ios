//
//  FormNavigation.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/02/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation
import UIKit

class FormNavigation: DeepLinkNavigationProtocol {
    
    //
    // MARK: - Properties
    let nameForm: String?
    lazy var formViewModel: FormViewModel = {
        let formViewModel = FormViewModel()
        return formViewModel
    }()
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameters:
    ///   - nameForm: String
    init(nameForm: String?) {
        self.nameForm = nameForm
    }
    
    //
    // MARK: - Functions
    
    /// Go to screen
    func goToScreen() {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        if appDelegate.window?.rootViewController is UITabBarController {
            let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
            tabBarController.selectedIndex = 1
            if tabBarController.selectedViewController is UINavigationController {
                let navigationController = (tabBarController.selectedViewController as? UINavigationController)!
                navigationController.popViewController(animated: true)
                if navigationController.topViewController is FormViewController {
                    
                    self.formViewModel.umbrella = UmbrellaDatabase.umbrellaStatic
                    for form in self.formViewModel.umbrella.loadFormByCurrentLanguage() where form.fileName == self.nameForm {
                            let storyboard = UIStoryboard(name: "Form", bundle: Bundle.main)
                            let viewcontroller = (storyboard.instantiateViewController(withIdentifier: "FillFormViewController") as? FillFormViewController)!
                            viewcontroller.fillFormViewModel.form = form
                            
                            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                            if appDelegate.window?.rootViewController is UITabBarController {
                                let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
                                if tabBarController.selectedViewController is UINavigationController {
                                    let navigationController = (tabBarController.selectedViewController as? UINavigationController)!
                                    navigationController.pushViewController(viewcontroller, animated: true)
                                }
                            }
                            break
                    }
                }
            }
        }
    }
    
}
