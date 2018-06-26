//
//  ViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import SQLite
import MarkdownView

class ViewController: UIViewController {
    
    @IBOutlet weak var markDownView: MarkdownView!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    //
    // MARK: - Properties
    lazy var homeViewModel: HomeViewModel = {
        let homeViewModel = HomeViewModel()
        return homeViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        homeViewModel.clone(witUrl: Config.gitBaseURL, completion: { progress in
            DispatchQueue.main.async {
                self.progressView.setProgress(progress, animated: true)
            }
            
            if progress == 1.0 {
                DispatchQueue.main.async {
                    self.progressView.isHidden = true
                    self.homeViewModel.parseTent()
                }
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
