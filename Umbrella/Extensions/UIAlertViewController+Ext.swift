//
//  UIAlertViewController+Ext.swift
//  Umbrella
//
//  Created by Lucas Correa on 13/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

var kTag = "kTag"

//
// MARK: - UIAlertAction
extension UIAlertAction {
    var tag: NSInteger? {
        get {
            return (objc_getAssociatedObject(self, &kTag) as? NSInteger)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &kTag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

// MARK: - UIAlertController
extension UIAlertController {
    public typealias DismissBlock = (_ btnIndex: NSInteger) -> Swift.Void
    public typealias CancelBlock = () -> Swift.Void
    
    public class func alert(title: String?, message: String?) {
        let titleStr = title != nil ? title : ""
        let messageStr = message != nil ? message : ""
        
        let alertVC = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        self.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    
    public class func alert(title: String?, message: String?, cancelButtonTitle: String?) {
        let titleStr = title != nil ? title : ""
        let messageStr = message != nil ? message : ""
        let cancelButtonTitleStr = cancelButtonTitle != nil ? cancelButtonTitle : ""
        
        let alertVC = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: cancelButtonTitleStr, style: .cancel, handler: nil))
        self.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    
    public class func alert(title: String?, message: String?, cancelButtonTitle: String?, otherButtons: NSArray?, dismiss: DismissBlock? = nil, cancel: CancelBlock? = nil) {
        let titleStr = title != nil ? title : ""
        let messageStr = message != nil ? message : ""
        let cancelButtonTitleStr = cancelButtonTitle != nil ? cancelButtonTitle : ""
        
        let alertVC = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: cancelButtonTitleStr, style: .cancel, handler: { _ in
            if cancel != nil {
                cancel!()
            }
            
        }))
        
        if otherButtons?.count != 0 && otherButtons != nil {
            for index in 1...otherButtons!.count {
                let btnTitle = String(describing: otherButtons![index - 1])
                let actionItem = UIAlertAction(title: btnTitle, style: .default, handler: { (actionItem) in
                    dismiss!(actionItem.tag!)
                })
                
                actionItem.tag = index - 1
                alertVC.addAction(actionItem)
            }
            
            self.topViewController()?.present(alertVC, animated: true, completion: nil)
            return
        }
        
        self.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
    
    public class func alertSheet(title: String?, message: String?, buttons: NSArray?, dismiss: DismissBlock? = nil, cancel: CancelBlock? = nil) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: { _ in
            if cancel != nil {
                cancel!()
            }
        }))
        
        if buttons?.count != 0 && buttons != nil {
            
            for index in 1...buttons!.count {
                let btnTitle = String(describing: buttons![index - 1])
                let actionItem = UIAlertAction(title: btnTitle, style: .default, handler: { (actionItem) in
                    if dismiss != nil {
                        dismiss!(actionItem.tag!)
                    }
                })
                
                actionItem.tag = index - 1
                alertVC.addAction(actionItem)
            }
            
            self.topViewController()?.present(alertVC, animated: true, completion: nil)
            return
        }
        self.topViewController()?.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - UIViewController

extension UIViewController {
    
    class func getCurrentWindow() -> UIWindow? {
        
        var window: UIWindow? = UIApplication.shared.keyWindow
        
        if window?.windowLevel != UIWindow.Level.normal {
            
            for tempWindow in UIApplication.shared.windows where tempWindow.windowLevel == UIWindow.Level.normal {
                window = tempWindow
                break
            }
        }
        
        return window
    }
    
    class func getCurrentViewController1() -> UIViewController? {
        var viewController: UIViewController?
        let window: UIWindow? = self.getCurrentWindow()
        let frontView = window?.subviews.first
        if let nextResponder = frontView?.next {
            if (nextResponder.isKind(of: UIViewController.classForCoder())) {
                viewController = nextResponder as? UIViewController
            } else {
                viewController = window?.rootViewController
            }
        }
        
        return viewController
    }
    
    class func topViewController() -> UIViewController? {
        
        return self.topViewControllerWithRootViewController(viewController: self.getCurrentWindow()?.rootViewController)
    }
    
    class func topViewControllerWithRootViewController(viewController :UIViewController?) -> UIViewController? {
        
        if viewController == nil {
            return nil
        }
        
        if let viewcontroller = viewController {
            if viewcontroller.presentedViewController != nil {
                return self.topViewControllerWithRootViewController(viewController: viewcontroller.presentedViewController!)
            } else if viewcontroller.isKind(of: UITabBarController.self) {
                return self.topViewControllerWithRootViewController(viewController: (viewcontroller as? UITabBarController)!.selectedViewController)
            } else if viewcontroller.isKind(of: UINavigationController.self) {
                return self.topViewControllerWithRootViewController(viewController: (viewcontroller as? UINavigationController)!.visibleViewController)
            } else {
                return viewcontroller
            }
        }
        
        return viewController
    }
}
