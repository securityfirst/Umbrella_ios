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
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var retryButton: UIButton!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    //
    // MARK: - Properties
    lazy var homeViewModel: HomeViewModel = {
        let homeViewModel = HomeViewModel()
        return homeViewModel
    }()
    
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
    func loadTent() {
        #if !TESTING
        homeViewModel.clone(witUrl: Config.gitBaseURL, completion: { gitProgress in
            DispatchQueue.main.async {
                self.progressView.setProgress(gitProgress/2.0, animated: true)
            }
            
            if gitProgress == 1.0 {
                self.homeViewModel.parseTent(completion: { progress in
                    DispatchQueue.main.async {
                        self.messageLabel.text = "Updating the database"
                        self.progressView.setProgress(gitProgress/2.0+progress/2.0, animated: true)
                        
                        if gitProgress + progress == 2.0 {
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
