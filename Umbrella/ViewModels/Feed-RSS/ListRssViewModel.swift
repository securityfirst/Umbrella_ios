//
//  ListRssViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import FeedKit

class ListRssViewModel {
    
    //
    // MARK: - Properties
    var items: [RSSFeedItem]
    
    //
    // MARK: - Init
    init() {
        items = [RSSFeedItem]()
    }
}
