//
//  LoadingViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import SQLite

class LoadingViewController: UIViewController {
  
    //
    // MARK: - Properties
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    lazy var loadingViewModel: LoadingViewModel = {
        let loadingViewModel = LoadingViewModel()
        return loadingViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTent()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // MARK: - Functions
    
    /// Load the tent, do a clone, parse and add on database
    func loadTent() {
        #if !TESTING
        if !loadingViewModel.checkIfExistClone(url: Config.gitBaseURL, pathDirectory: .documentDirectory) {
            loadingViewModel.clone(witUrl: Config.gitBaseURL, completion: { gitProgress in
                DispatchQueue.main.async {
                    self.progressView.setProgress(gitProgress/2.0, animated: true)
                }
                
                if gitProgress == 1.0 {
                    self.loadingViewModel.parseTent(completion: { progress in
                        DispatchQueue.main.async {
                            self.messageLabel.text = "Updating the database"
                            self.progressView.setProgress(gitProgress/2.0+progress/2.0, animated: true)
                            
                            if gitProgress + progress == 2.0 {
                                NotificationCenter.default.post(name: Notification.Name("UmbrellaTent"), object: Umbrella(languages: self.loadingViewModel.languages, forms: self.loadingViewModel.forms))
                                self.view.removeFromSuperview()
                            }
                        }
                    })
                }
            }, failure: { _ in
                DispatchQueue.main.async {
                    self.messageLabel.text = "Error in load the tent"
                    self.activityIndicatorView.isHidden = true
                    self.retryButton.isHidden = false
                }
            })
        } else {
            self.messageLabel.text = "Getting the database"
            
            loadingViewModel.loadUmbrellaOfDatabase()
            DispatchQueue.main.async {
                self.progressView.setProgress(1.0, animated: true)
                
                delay(1.5) {
                    self.view.removeFromSuperview()
                }
            }
            print("Exist")
        }
        #endif
    }
    
    //
    // MARK: - Actions
    @IBAction func retryAction(_ sender: Any) {
        retryButton.isHidden = true
        activityIndicatorView.isHidden = false
        messageLabel.text = "Clone of tent"
        loadTent()
    }
}
