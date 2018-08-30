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
    @IBOutlet weak var rssTableView: UITableView!
    
    var rssDefaultArray = [
        ["url": "https://threatpost.com/feed/"],
        ["url": "https://krebsonsecurity.com/feed/"],
        ["url": "http://feeds.feedburner.com/NakedSecurity"],
        ["url": "http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk"],
        ["url": "http://rss.cnn.com/rss/edition.rss"],
        ["url": "https://www.aljazeera.com/xml/rss/all.xml"],
        ["url": "https://www.theguardian.com/world/rss"]
    ]
    
    var rssArray: [Result] = [Result]()
    weak var delegate: RssViewDelegate!
    
    //
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rssTableView.rowHeight = UITableViewAutomaticDimension
        self.rssTableView.estimatedRowHeight = 44.0
        
        var count = 0
        for item in rssDefaultArray {
            let feedURL = URL(string: item["url"]!)!
            let parser = FeedParser(URL: feedURL)
            parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
                count += 1
                self.rssArray.append(result)
                DispatchQueue.main.async {
                    if count == self.rssDefaultArray.count && count > 0 {
                        self.rssTableView.reloadData()
                    }
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension RssView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.formViewModel.umbrella.forms.count
        return self.rssArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RssCell = (tableView.dequeueReusableCell(withIdentifier: "RssCell", for: indexPath) as? RssCell)!
        //        cell.configure(withViewModel: formViewModel, indexPath: indexPath)
        //        cell.delegate = self
        
        let item = self.rssArray[indexPath.row]
        cell.titleLabel.text = item.rssFeed?.title
        cell.descriptionLabel.text = item.rssFeed?.description
        return cell
    }
}

// MARK: - UITableViewDelegate
extension RssView: UITableViewDelegate {
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 106.0
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.rssArray[indexPath.row]
        if let rssFeed = item.rssFeed {
            self.delegate.openRss(rss: rssFeed)
        }
    }
}
