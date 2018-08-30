//
//  FeedViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import FeedKit

class FeedViewController: UIViewController {

    //
    // MARK: - Properties
    @IBOutlet weak var feedView: FeedView!
    @IBOutlet weak var rssView: RssView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Feed".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rssView.delegate = self
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rssSegue" {
         let destination = (segue.destination as? ListRssViewController)!
            
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func choiceAction(_ sender: UISegmentedControl) {
        self.feedView.isHidden = sender.selectedSegmentIndex == 1
        self.rssView.isHidden = sender.selectedSegmentIndex == 0
    }
}

extension FeedViewController: RssViewDelegate {
    func openRss(rss: RSSFeed) {
        self.performSegue(withIdentifier: "rssSegue", sender: rss)
    }
}
