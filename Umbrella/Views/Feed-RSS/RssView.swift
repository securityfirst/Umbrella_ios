//
//  RssView.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import FeedKit

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
        loadRss()
    }
    
    //
    // MARK: - Functions
    
    /// Load all the RSS
    func loadRss() {
        rssViewModel.loadRSS {
            self.rssTableView.isHidden = (self.rssViewModel.rssArray.count == 0)
            self.rssTableView.reloadData()
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
        cell.configure(withViewModel: rssViewModel, indexPath: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RssView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.rssViewModel.rssArray[indexPath.row]
        if let rssFeed = item.rssFeed {
            self.delegate.openRss(rss: rssFeed)
        }
    }
}
