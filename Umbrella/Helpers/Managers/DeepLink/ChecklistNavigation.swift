//
//  ChecklistNavigation.swift
//  Umbrella
//
//  Created by Lucas Correa on 12/02/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation
import UIKit

class ChecklistNavigation: DeepLinkNavigationProtocol {
    
    //
    // MARK: - Properties
    
    //
    // MARK: - Initializer
    
    /// Init
    init() {
    }
    
    //
    // MARK: - Functions
    
    /// Go to screen
    func goToScreen() {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        if appDelegate.window?.rootViewController is UITabBarController {
            let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
            tabBarController.selectedIndex = 2
        }
    }
    
}
