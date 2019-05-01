//
//  RssView.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import FeedKit
import Localize_Swift

protocol RssViewDelegate: class {
    func openRss(rss: RSSFeed)
}

class RssView: UIView {
    
    //
    // MARK: - Properties
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var rssTableView: UITableView!
    
    lazy var rssViewModel: RssViewModel = {
        let rssViewModel = RssViewModel()
        return rssViewModel
    }()
    
    weak var delegate: RssViewDelegate!
    
    //
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rssTableView.rowHeight = UITableView.automaticDimension
        self.rssTableView.estimatedRowHeight = 44.0
        
        self.emptyLabel.text = "There no RSS".localized()
        self.loadRss()
        
        NotificationCenter.default.addObserver(self, selector: #selector(RssView.updateRss(notification:)), name: Notification.Name("UmbrellaTent"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    //
    // MARK: - Functions
    
    /// Load all the RSS
    func loadRss() {
        self.rssViewModel.clearRss()
        self.rssViewModel.loadRSS {
            self.rssTableView.isHidden = (self.rssViewModel.rssArray.count == 0)
            self.rssTableView.reloadData()
        }
    }
    
    @objc func updateLanguage() {
        self.rssTableView.reloadData()
    }
    
    /// Update Rss
    ///
    /// - Parameter notification: NSNotification
    @objc func updateRss(notification: NSNotification) {
        delay(1) {
            self.loadRss()
        }
    }
}

// MARK: - UITableViewDataSource
extension RssView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rssViewModel.rssArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RssCell = (tableView.dequeueReusableCell(withIdentifier: "RssCell", for: indexPath) as? RssCell)!
        cell.configure(withViewModel: self.rssViewModel, indexPath: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RssView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.rssViewModel.rssArray[indexPath.row]
        if let rssFeed = item.result.rssFeed {
            self.delegate.openRss(rss: rssFeed)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            let item = self.rssViewModel.rssArray[indexPath.row]
            self.rssViewModel.rssArray.remove(at: indexPath.row)
            self.rssViewModel.remove(item.rssItem)
            
            self.rssTableView.reloadData()
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if self.rssViewModel.rssArray.indexExists(indexPath.row) {
            let item = self.rssViewModel.rssArray[indexPath.row]
            return self.rssViewModel.isCustom(rssFeed: item)
        }
        
        return false
    }
}
