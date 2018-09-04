//
//  ListRssViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 29/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import FeedKit

class ListRssViewController: UIViewController {
    
    //
    // MARK: - Properties
    var rssModeView: Int = 0
    @IBOutlet weak var rssModeViewButtonItem: UIBarButtonItem!
    @IBOutlet weak var listRssTableView: UITableView!
    lazy var listRssViewModel: ListRssViewModel = {
        let listRssViewModel = ListRssViewModel()
        return listRssViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RSS".localized()
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, self.title)
        
        let modeBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "rssCardChoice"), style: .plain, target: self, action: #selector(self.rssModeViewAction(_:)))
        modeBarButton.tintColor = #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        modeBarButton.accessibilityHint = "Card mode view".localized()
        self.navigationItem.rightBarButtonItem  = modeBarButton
        
        self.listRssTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailFeedSegue" {
            let destination = (segue.destination as? DetailRssViewController)!
            let rss = (sender as? RSSFeedItem)!
            destination.detailRssViewModel.item = rss
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func rssModeViewAction(_ sender: UIBarButtonItem) {
        if rssModeView == 0 {
            rssModeView = 1
            sender.image = #imageLiteral(resourceName: "rssListChoice")
            sender.accessibilityLabel = "You chose the Card mode view".localized()
        } else if rssModeView == 1 {
            rssModeView = 0
            sender.image = #imageLiteral(resourceName: "rssCardChoice")
            sender.accessibilityLabel = "You chose the List mode view".localized()
        }
        
        self.listRssTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ListRssViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listRssViewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if rssModeView == 0 {
            let cell: ListRssCell = (tableView.dequeueReusableCell(withIdentifier: "ListRssCell", for: indexPath) as? ListRssCell)!
            cell.configure(withViewModel: listRssViewModel, indexPath: indexPath)
            
//            if indexPath.row == 0 {
//                let item = listRssViewModel.items[indexPath.row]
//                UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, item.title)
// UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, item.title)
//
//            }
            
            return cell
        } else {
            let cell: CardRssCell = (tableView.dequeueReusableCell(withIdentifier: "CardRssCell", for: indexPath) as? CardRssCell)!
            cell.configure(withViewModel: listRssViewModel, indexPath: indexPath)
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ListRssViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.listRssViewModel.items[indexPath.row]
        self.performSegue(withIdentifier: "detailFeedSegue", sender: item)
    }
}
