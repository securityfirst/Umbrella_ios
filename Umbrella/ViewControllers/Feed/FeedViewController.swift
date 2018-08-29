//
//  FeedViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var feedView: FeedView!
    @IBOutlet weak var rssView: RssView!
    var rssModeView: Int = 0
    @IBOutlet weak var rssModeViewButtonItem: UIBarButtonItem!
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Feed".localized()
        rssModeViewButtonItem.isEnabled = false
        rssModeViewButtonItem.tintColor = UIColor.clear
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
    
    @IBAction func choiceAction(_ sender: UISegmentedControl) {
        self.feedView.isHidden = sender.selectedSegmentIndex == 1
        self.rssView.isHidden = sender.selectedSegmentIndex == 0
        
        if !self.rssView.isHidden {
            rssModeViewButtonItem.isEnabled = true
            rssModeViewButtonItem.tintColor = #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        } else {
            rssModeViewButtonItem.isEnabled = false
            rssModeViewButtonItem.tintColor = UIColor.clear
        }
    }
    
    @IBAction func rssModeViewAction(_ sender: UIBarButtonItem) {
        if rssModeView == 0 {
           rssModeView = 1
           sender.image = #imageLiteral(resourceName: "rssListChoice")
        } else if rssModeView == 1 {
            rssModeView = 0
            sender.image = #imageLiteral(resourceName: "rssCardChoice")
        }
    }
}
