//
//  PathwayViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 23/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class PathwayViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var pathwayViewModel: PathwayViewModel = {
        let pathwayViewModel = PathwayViewModel()
        return pathwayViewModel
    }()
    
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var pathwayTableview: UITableView!
    @IBOutlet weak var showMeButton: UIButton!
    @IBOutlet weak var noThanksButton: UIButton!
    
    var didClosePathway: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = "What do you need most?".localized()
        self.messageLabel.text = "Select a guide to start your security journey, or bookmark any guide for later.".localized()
        self.showMeButton.setTitle("SHOW ME".localized(), for: .normal)
        self.noThanksButton.setTitle("NO THANKS, I'LL EXPLORE ON MY OWN".localized(), for: .normal)
        loadPathways()
    }
    
    fileprivate func loadPathways() {
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        
        let language = self.pathwayViewModel.getLanguage(name: languageName)
        let success = self.pathwayViewModel.listPathways(languageId: language.id)
        
        if success {
            self.pathwayViewModel.updatePathways()
            self.loadingActivityIndicator.isHidden = true
            self.pathwayTableview.isHidden = false
            self.pathwayTableview.reloadData()
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.didClosePathway?()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showMeAction(_ sender: Any) {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        if appDelegate.window?.rootViewController is UITabBarController {
            let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
            tabBarController.selectedIndex = 2
        }
        
        self.dismiss(animated: true) {
            self.didClosePathway?()
        }
    }
}

// MARK: - UITableViewDataSource
extension PathwayViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let category = self.pathwayViewModel.category {
            return category.checkLists.count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PathwayCell = (tableView.dequeueReusableCell(withIdentifier: "PathwayCell", for: indexPath) as? PathwayCell)!
        
        cell.configure(withViewModel: self.pathwayViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PathwayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let checklist = self.pathwayViewModel.category?.checkLists[indexPath.row]
        
        if let checklist = checklist {
            checklist.favourite = !checklist.favourite
            
            let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
            let language = self.pathwayViewModel.getLanguage(name: languageName)
            
            let pathwayChecklistChecked = PathwayChecklistChecked(name: checklist.name ?? "" , checklistId: checklist.id, languageId: language.id)
            
            pathwayChecklistChecked.totalItemsChecklist = checklist.countItemCheck()
            
            if checklist.favourite {
                self.pathwayViewModel.insert(pathwayChecklistChecked)
            } else {
                self.pathwayViewModel.remove(pathwayChecklistChecked)
                self.pathwayViewModel.removelAllChecks(checklist: checklist)
            }
            
            self.pathwayTableview.reloadData()
        }
    }
}
