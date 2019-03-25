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
    var rssArray: [(rssItem: RssItem, result: Result)] = [(RssItem, Result)]()
    var rssUrlArray: [RssItem] = [RssItem]()
    
    var sqlManager: SQLManager
    lazy var rssItemDao: RssItemDao = {
        let rssItemDao = RssItemDao(sqlProtocol: self.sqlManager)
        return rssItemDao
    }()
    var count = 0
    
    //
    // MARK: - Init
    init() {
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    //
    // MARK: - Functions
    
    /// Load all rss default
    ///
    /// - Parameter completion: closure
    func loadRSS(feeds: [[String: String]] = RSS.feeds, completion: @escaping (() -> Void)) {
        self.count = 0
        self.rssArray.removeAll()
        
        _ = self.rssItemDao.createTable()
        self.rssUrlArray = self.rssItemDao.list()
        
        if self.rssUrlArray.count == 0 {
            for item in feeds {
                let rssItem = RssItem(url: item["url"]!, isCustom: 0)
                _ = self.rssItemDao.insert(rssItem)
                self.rssUrlArray.append(rssItem)
            }
        }
        
        for item in self.rssUrlArray {
            let feedURL = URL(string: item.url)!
            let parser = FeedParser(URL: feedURL)
            
            DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                let result = parser.parse()
                //            parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
                self.count += 1
                
                if result.isSuccess {
                    self.rssArray.append((item,result))
                }
                
                DispatchQueue.main.async {
                    if self.count == self.rssUrlArray.count && self.count > 0 {
                        completion()
                    }
                }
                //            }
            }
        }
    }
    
    /// Load all rss default
    ///
    /// - Parameter completion: closure
    func loadSpecifyRSS(rssItem: RssItem, completion: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        
        let feedURL = URL(string: rssItem.url)!
        let parser = FeedParser(URL: feedURL)
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let result = parser.parse()
            
            if result.isSuccess {
                self.rssUrlArray.append(rssItem)
                self.rssArray.append((rssItem,result))
                DispatchQueue.main.async {
                    completion()
                }
            } else {
                failure(result.error!)
            }
        }
    }
    
    /// Insert a new Rss into the database
    ///
    /// - Parameter url: String
    func insert(_ url: String) {
        let rssItem = RssItem(url: url, isCustom: 1)
        _ = self.rssItemDao.insert(rssItem)
    }
    
    /// Remove Rss
    ///
    /// - Parameter rssItem: RssItem
    func remove(_ rssItem: RssItem) {
        _ = self.rssItemDao.remove(rssItem)
    }
    
    /// Check whether is custom rss
    func isCustom(rssFeed: (rssItem: RssItem, result: Result)) -> Bool {
        
        let item = rssFeed.rssItem
        
        let rssItem = self.rssUrlArray.filter { $0.url == item.url}.first
        
        if let rssItem = rssItem {
            return rssItem.custom == 1 ? true : false
        }
        
        return false
    }
}
