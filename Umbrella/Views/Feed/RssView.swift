//
//  RssView.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class RssView: UIView {
    
    @IBOutlet weak var rssTableView: UITableView!
    
//    { "link":"https://threatpost.com/feed/"},
//    { "link":"https://krebsonsecurity.com/feed/"},
//    { "link":"http://feeds.feedburner.com/NakedSecurity"},
//    { "link":"http://feeds.bbci.co.uk/news/world/rss.xml?edition=uk"},
//    { "link":"http://rss.cnn.com/rss/edition.rss"},
//    { "link":"https://www.aljazeera.com/xml/rss/all.xml"},
//    { "link":"https://www.theguardian.com/world/rss"}
    var rssDefaultArray = [
        ["title": "The first stop for security news | Threatpost", "desc": "The first stop for security news", "url": "https://threatpost.com/feed/"]
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rssTableView.rowHeight = UITableViewAutomaticDimension
        self.rssTableView.estimatedRowHeight = 44.0
    }
}

// MARK: - UITableViewDataSource
extension RssView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return self.formViewModel.umbrella.forms.count
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RssCell = (tableView.dequeueReusableCell(withIdentifier: "RssCell", for: indexPath) as? RssCell)!
        //        cell.configure(withViewModel: formViewModel, indexPath: indexPath)
        //        cell.delegate = self
        
        var item = rssDefaultArray[indexPath.row]
        cell.titleLabel.text = item["title"]
        cell.descriptionLabel.text = item["desc"]
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
    }
}
