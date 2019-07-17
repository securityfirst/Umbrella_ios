//
//  AppDelegate.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import SQLite
import Localize_Swift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var isShow: Bool = false
    var demoViewController: DemoSettingViewController!
    var loginViewController: LoginViewController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(show))
        longPressGesture.numberOfTouchesRequired = 2
        getWindow().addGestureRecognizer(longPressGesture)
        
        let repository = UserDefaults.standard.object(forKey: "repository")
        if repository == nil {
            print(Config.gitBaseURL.absoluteString)
            UserDefaults.standard.set(Config.gitBaseURL.absoluteString, forKey: "repository")
        }
        
        var language = UserDefaults.standard.object(forKey: "Language")
        if language == nil {
            let langStr = Locale.current.languageCode
            UserDefaults.standard.set(langStr, forKey: "Language")
        }
        
        language = UserDefaults.standard.object(forKey: "Language")
        
        if let language: String = language as? String {
            // Arabic(ar) or Persian Farsi(fa)
            if language == "ar" || language == "fa" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            } else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
        }
        
        // Fetch data once 30 minutes.
        UIApplication.shared.setMinimumBackgroundFetchInterval(1800)
        
        //        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        //        tapGesture.delegate = self
        //        window?.addGestureRecognizer(tapGesture)
        
        SyncManager.shared.sync()
        return true
    }
    
    func getWindow() -> UIView {
        if let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow
        } else {
            return UIApplication.shared.windows[0]
        }
    }
    
    @objc func show() {
        
        if self.isShow {
            self.demoViewController.view.isHidden = false
            self.demoViewController.gitText.becomeFirstResponder()
            return
        }
        self.isShow = true
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.demoViewController = (storyboard.instantiateViewController(withIdentifier: "DemoSettingViewController") as? DemoSettingViewController)!
        
        getWindow().addSubview(self.demoViewController.view)
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let foundViewController = self.window?.rootViewController?.children.filter { $0 is LoginViewController }
        
        if foundViewController?.count == 0 {
            let passwordCustom: Bool = UserDefaults.standard.object(forKey: "passwordCustom") as? Bool ?? false
            if passwordCustom {
                let storyboard = UIStoryboard(name: "Account", bundle: Bundle.main)
                self.loginViewController = (storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController)!
                self.window?.rootViewController?.add(self.loginViewController)
            }
        }
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication,
                     performFetchWithCompletionHandler completionHandler:
        @escaping (UIBackgroundFetchResult) -> Void) {
        
        if application.backgroundRefreshStatus == .available {
            print("Available")
        }
        
        if application.applicationState == .background {
            print("Background")
        }
        
        if application.backgroundRefreshStatus == .denied {
            print("denied")
        }
        
        if application.backgroundRefreshStatus == .restricted {
            print("restricted")
        }
        NotificationCenter.default.post(name: Notification.Name("UpdateFeed"), object: nil)
        
        completionHandler(.newData)
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        print("handleEventsForBackgroundURLSession")
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        //        print("\(url.host!)\(url.path)")
        if  url.scheme == "umbrella" {
            if deepLinkManager.handleDeeplink(url: url) {
                deepLinkManager.checkDeepLink()
            }
        }
        
        return true
    }
}

extension AppDelegate: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // User tapped on screen, do whatever you want to do here.
        let isAcceptedTerm = UserDefaults.standard.bool(forKey: "acceptTerm")
        
        if isAcceptedTerm {
            //            print("Touches")
        }
        
        return false
    }
}
