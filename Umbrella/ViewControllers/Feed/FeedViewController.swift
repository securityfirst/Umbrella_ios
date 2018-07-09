//
//  FeedViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoadingViewController")
        
        UIApplication.shared.keyWindow?.addSubview(controller.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
