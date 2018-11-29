//
//  AppDelegate.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
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
        
        //Fabric
        Fabric.with([Crashlytics.self])
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(show))
        longPressGesture.numberOfTouchesRequired = 2
        getWindow().addGestureRecognizer(longPressGesture)
        
        let gitHubDemo = UserDefaults.standard.object(forKey: "gitHubDemo")
        if gitHubDemo == nil {
//            UserDefaults.standard.set("https://github.com/securityfirst/umbrella-content", forKey: "gitHubDemo")
            UserDefaults.standard.set("https://github.com/lucascorrea/umbrella-content", forKey: "gitHubDemo")
        }
        
        let language = UserDefaults.standard.object(forKey: "Language")
        if language == nil {
            UserDefaults.standard.set("en", forKey: "Language")
        }
        
        // Fetch data once 30 minutes.
        UIApplication.shared.setMinimumBackgroundFetchInterval(1800)
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (permissionGranted, error) in
            print(error as Any)
        }
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
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        let passwordCustom: Bool = UserDefaults.standard.object(forKey: "passwordCustom") as? Bool ?? false
        if passwordCustom {
            let storyboard = UIStoryboard(name: "Account", bundle: Bundle.main)
            self.loginViewController = (storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController)!
            
            self.window?.rootViewController?.present(self.loginViewController, animated: false, completion: nil)
        }
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
       
        print(application.backgroundRefreshStatus)
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
}
