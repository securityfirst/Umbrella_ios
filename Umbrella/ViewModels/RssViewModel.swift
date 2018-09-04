//
//  RssViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import FeedKit

class RssViewModel {
    
    //
    // MARK: - Properties
    var rssArray: [Result] = [Result]()
    var sqlManager: SQLManager
    lazy var rssItemDao: RssItemDao = {
        let rssItemDao = RssItemDao(sqlProtocol: self.sqlManager)
        return rssItemDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    /// Load all rss default
    ///
    /// - Parameter completion: closure
    func loadRSS(feeds: [[String: String]] = RSS.feeds, completion: @escaping (() -> Void)) {
        var count = 0
        self.rssArray.removeAll()
        
        _ = self.rssItemDao.createTable()
        var rssUrlArray = self.rssItemDao.list()
        
        if rssUrlArray.count == 0 {
            for item in feeds {
            let rssItem = RssItem(url: item["url"]!)
            _ = self.rssItemDao.insert(rssItem)
                rssUrlArray.append(rssItem)
            }
        }
        
        for item in rssUrlArray {
            let feedURL = URL(string: item.url)!
            let parser = FeedParser(URL: feedURL)
            parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
                count += 1
                
                if result.isSuccess {
                    self.rssArray.append(result)
                }
                
                DispatchQueue.main.async {
                    if count == rssUrlArray.count && count > 0 {
                        completion()
                    }
                }
            }
        }
    }
    
    /// Insert a new Rss into the database
    ///
    /// - Parameter url: String
    func insert(_ url: String) {
        let rssItem = RssItem(url: url)
        _ = self.rssItemDao.insert(rssItem)
    }
    
}
