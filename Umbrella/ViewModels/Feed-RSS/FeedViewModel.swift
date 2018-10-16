//
//  FeedViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

class FeedViewModel {
    
    //
    // MARK: - Properties
    var location = ""
    var sources = [Int]()
    var feedItems: [FeedItem] = [FeedItem]()
    
    //
    // MARK: - Init
    init() {
        
    }
    
    func requestFeed(completion: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        
        var sourceString = ""
        for (index, value) in sources.enumerated() {
            
            if index + 1 != sources.count {
                sourceString += "\(value),"
            } else {
                sourceString += "\(value)"
            }
        }
        
        let url = URL(string: "https://api.secfirst.org/v3/feed?country=\(location)&sources=\(sourceString)&since=0")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let feedItems = try JSONDecoder().decode([FeedItem].self, from: data)
                self.feedItems = feedItems
                completion()
            } catch let error {
                print(error)
                failure(error)
            }
            }.resume()
    }
    
}
