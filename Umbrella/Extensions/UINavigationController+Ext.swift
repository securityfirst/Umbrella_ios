//
//  UINavigationController+Ext.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/01/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func removeAnyViewControllers(ofKind kind: AnyClass) {
        self.viewControllers = self.viewControllers.filter { !$0.isKind(of: kind)}
    }
    
    func containsViewController(ofKind kind: AnyClass) -> Bool {
        return self.viewControllers.contains(where: { $0.isKind(of: kind) })
    }
}
