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
    
    //
    // MARK: - Init
    init() {
        
    }
    
    /// Load all rss default
    ///
    /// - Parameter completion: closure
    func loadRSS(completion: @escaping (() -> Void)) {
        var count = 0
        for item in RSS.feeds {
            let feedURL = URL(string: item["url"]!)!
            let parser = FeedParser(URL: feedURL)
            parser.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
                count += 1
                self.rssArray.append(result)
                DispatchQueue.main.async {
                    if count == RSS.feeds.count && count > 0 {
                        completion()
                    }
                }
            }
        }
    }
    
}
