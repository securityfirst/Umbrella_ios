//
//  FeedViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Feed".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.keyWindow?.rootViewController?.view.alpha = 0
        let isAcceptTerm = UserDefaults.standard.bool(forKey: "acceptTerm")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if isAcceptTerm {
            let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
            UIApplication.shared.keyWindow?.addSubview(controller.view)
            controller.loadTent {
            }
        } else {
            let controller = storyboard.instantiateViewController(withIdentifier: "TourViewController")
            self.present(controller, animated: false, completion: nil)
        }
        
        UIApplication.shared.keyWindow?.rootViewController?.view.alpha = 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Actions
    
    @IBAction func choiceAction(_ sender: Any) {
    }
}
