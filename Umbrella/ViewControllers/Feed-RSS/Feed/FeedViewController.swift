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
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Feed".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBarButton.isEnabled = false
        addBarButton.tintColor = UIColor.clear
        addBarButton.accessibilityElementsHidden = true
        addBarButton.isAccessibilityElement = false
        
        feedView.delegate = self
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
        
         NotificationCenter.default.addObserver(self, selector: #selector(FeedViewController.updateLocation(notification:)), name: Notification.Name("UpdateLocation"), object: nil)
    }
    
    @objc func updateLocation(notification: NSNotification) {
        let userInfo = notification.userInfo
        
        if let name = userInfo?["location"] as? String {
            feedView.locationLabel.text = name
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rssSegue" {
            let destination = (segue.destination as? ListRssViewController)!
            let rss = (sender as? RSSFeed)!
            
            if let items = rss.items {
                destination.listRssViewModel.items = items
            }
        }
    }
    
    /// Validate if there is an url valid
    ///
    /// - Parameter urlString: String
    /// - Returns: Bool
    func validateUrl (urlString: String) -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
    }
    
    //
    // MARK: - Actions
    
    @IBAction func choiceAction(_ sender: UISegmentedControl) {
        self.feedView.isHidden = sender.selectedSegmentIndex == 1
        self.rssView.isHidden = sender.selectedSegmentIndex == 0
        
        addBarButton.accessibilityElementsHidden = self.feedView.isHidden
        addBarButton.isAccessibilityElement = !self.rssView.isHidden
        addBarButton.isEnabled = !self.rssView.isHidden
        addBarButton.tintColor = addBarButton.isEnabled ? #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1) : UIColor.clear
    }
    
    @IBAction func addAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Feed Sources".localized(), message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "http://"
            textField.keyboardType = UIKeyboardType.URL
        }
        let saveAction = UIAlertAction(title: "Save".localized(), style: UIAlertAction.Style.destructive, handler: { _ in
            let firstTextField = alertController.textFields![0] as UITextField
            print(firstTextField.text ?? "")
            
            if (firstTextField.text?.count)! > 0 {
                if self.validateUrl(urlString: firstTextField.text!) {
                    self.rssView.rssViewModel.insert(firstTextField.text!)
                    self.rssView.loadRss()
                }
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

//
// MARK: - RssViewDelegate
extension FeedViewController: RssViewDelegate {
    func openRss(rss: RSSFeed) {
        self.performSegue(withIdentifier: "rssSegue", sender: rss)
    }
}

//
// MARK: - FeedViewDelegate
extension FeedViewController: FeedViewDelegate {
    func choiceLocation() {
        self.performSegue(withIdentifier: "locationSegue", sender: nil)
    }
}
