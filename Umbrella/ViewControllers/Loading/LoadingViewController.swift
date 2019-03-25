//
//  LoadingViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import SQLite
import SystemConfiguration

enum ConnectionType {
    case connectionTypeUnknown
    case connectionTypeNone
    case connectionType3G
    case connectionTypeWiFi
}

class LoadingViewController: UIViewController {
    
    //
    // MARK: - Properties
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tipsLabel: UILabel!
    
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    var completion: (() -> Void)?
    
    lazy var loadingViewModel: LoadingViewModel = {
        let loadingViewModel = LoadingViewModel()
        return loadingViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tipsLabel.text = "Umbrella has lots of lessons and content. The first time you use the app these are downloaded so that they work offline. The process should take about 3 minutes at most.".localized()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // MARK: - Functions
    
    /// Load the tent, do a clone, parse and add on database
    func loadTent(completion: @escaping () -> Void) {
        self.completion = completion
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: self.messageLabel)
        self.viewHeightConstraint.constant = 230
        self.tipsLabel.text = "Umbrella has lots of lessons and content. The first time you use the app these are downloaded so that they work offline. The process should take about 3 minutes at most.".localized()
        
        if !self.loadingViewModel.checkIfExistClone(pathDirectory: .documentDirectory) {
            UIApplication.shared.isIdleTimerDisabled = true
            
            let status = connectionStatus()
            
            if status == ConnectionType.connectionType3G {
                UIApplication.shared.keyWindow!.makeToast("Downloading content can take a few minutes. Please wait.".localized(), duration: 10.0, position: .bottom)
            }
            
            // I added this initial fake count, why the SwiftGit2 framework does not return me in the callback when it is downloading only when it finishes that it returns, so I put that fake percent from 0.0 to 1.0 so the user who thinks the download is stopped .
            var fakeCount: Float = 0.0
            let timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { timer in
                fakeCount+=0.1
                
                self.messageLabel.text = String(format: "\("Fetching Data".localized()) %.1f%%", fakeCount)
                
                if fakeCount >= 1.0 {
                    self.messageLabel.text = String(format: "\("Fetching Data".localized()) %.f%%", fakeCount)
                    if timer.isValid {
                        timer.invalidate()
                    }
                }
            }
        
            self.messageLabel.text = "\("Fetching Data".localized()) 0%"
            let repository = (UserDefaults.standard.object(forKey: "repository") as? String)!
            
            self.loadingViewModel.clone(witUrl: URL(string: repository)!, completion: { gitProgress in
                
                // SwiftGit2 callback
                DispatchQueue.main.async {
                    self.progressView.setProgress(gitProgress/2.0, animated: true)
                    self.messageLabel.text = String(format: "\("Fetching Data".localized()) %.f%%", gitProgress/2.0*100)
                    
                    if timer.isValid {
                        timer.invalidate()
                    }
                }
                
                if gitProgress == 1.0 {
                    DispatchQueue.main.async {
                        self.loadingViewModel.parseTent(completion: { progress in
                            DispatchQueue.main.async {
                                UIApplication.shared.isIdleTimerDisabled = false
                                self.progressView.setProgress(gitProgress/2.0+progress/2.0, animated: true)
                                self.messageLabel.text = String(format: "\("Updating the database".localized()) %.f%%", (gitProgress/2.0+progress/2.0)*100)
                                
                                if gitProgress + progress == 2.0 {
                                    NotificationCenter.default.post(name: Notification.Name("UmbrellaTent"), object: Umbrella(languages: self.loadingViewModel.languages, forms: self.loadingViewModel.forms, formAnswers: self.loadingViewModel.formAnswers))
                                    self.completion!()
                                    self.view.removeFromSuperview()
                                }
                            }
                        })
                    }
                }
            }, failure: { _ in
                DispatchQueue.main.async {
                    
                    if timer.isValid {
                        timer.invalidate()
                    }
                    
                    UIApplication.shared.isIdleTimerDisabled = false
                    self.messageLabel.text = "Error in load the tent".localized()
                    self.activityIndicatorView.isHidden = true
                    self.retryButton.isHidden = false
                    self.closeButton.isHidden = false
                }
            })
        } else {
            
            self.viewHeightConstraint.constant = 130
            self.tipsLabel.text = ""
            
            self.messageLabel.text = "Getting the database".localized()
            
            self.loadingViewModel.loadUmbrellaOfDatabase()
            DispatchQueue.main.async {
                self.progressView.setProgress(1.0, animated: true)
                
                delay(1.5) {
                    self.completion!()
                    self.view.removeFromSuperview()
                }
            }
            print("Exist")
        }
    }
    
    func connectionStatus() -> ConnectionType {
        let reachability = SCNetworkReachabilityCreateWithName(nil, "8.8.8.8")
        
        var flags : SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(reachability!, &flags) {
            return .connectionTypeUnknown
        }
        
        let connectionRequired = flags.contains(SCNetworkReachabilityFlags.connectionRequired)
        let isReachable = flags.contains(SCNetworkReachabilityFlags.reachable)
        let isWWAN = flags.contains(SCNetworkReachabilityFlags.isWWAN)
        
        if !connectionRequired && isReachable {
            if isWWAN {
                return .connectionType3G
            } else {
                return .connectionTypeWiFi
            }
        } else {
            return .connectionTypeNone
        }
    }
    
    //
    // MARK: - Actions
    @IBAction func retryAction(_ sender: Any) {
        retryButton.isHidden = true
        closeButton.isHidden = true
        activityIndicatorView.isHidden = false
        messageLabel.text = "Fetching Data".localized()
        loadTent(completion: self.completion!)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}
