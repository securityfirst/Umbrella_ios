//
//  FeedViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

class FeedViewModel: NSObject {
    
    //
    // MARK: - Properties
    var location = ""
    var sources = [Int]()
    var feedItems: [FeedItem] = [FeedItem]()
    private var session: URLSession!
    
    var savedCompletionHandler: (() -> Void)?
    
    //
    // MARK: - Init
    override init() {
        // Init variables
        super.init()
        let configuration = URLSessionConfiguration.background(withIdentifier: "org.secfirst.umbrella")
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    //
    /// Request feed
    ///
    /// - Parameters:
    ///   - completion: Closure
    ///   - failure: Closure
    func requestFeed(completion: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        // 1 = UN United Nations
        var sourceString = "1,"
        
        for (index, value) in sources.enumerated() {
            
            if index + 1 != sources.count {
                sourceString += "\(value),"
            } else {
                sourceString += "\(value)"
            }
        }
        
        let url = URL(string: String(format: Feed.feedUrl, "\(location)", "\(sourceString)"))!
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                self.feedItems.removeAll()
                let feedsDecode = try JSONDecoder().decode([FeedItem].self, from: data)
                self.feedItems = feedsDecode
                completion()
            } catch let error {
                print(error)
                failure(error)
            }
            }.resume()
    }
    
    /// Request feed in background
    ///
    /// - Parameters:
    ///   - completion: Closure
    ///   - failure: Closure
    func requestFeedInBackground(completion: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        self.savedCompletionHandler = completion
        var sourceString = ""
        for (index, value) in sources.enumerated() {
            
            if index + 1 != sources.count {
                sourceString += "\(value),"
            } else {
                sourceString += "\(value)"
            }
        }
        
        let url = URL(string: String(format: Feed.feedUrl, "\(location)", "\(sourceString)"))!
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 20)
        request.httpMethod = "GET"
//        request.httpBody = parameters.data(using: .utf8)
        session.downloadTask(with: request).resume()
    }
}

extension FeedViewModel: URLSessionDelegate {
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        DispatchQueue.main.async {
            self.savedCompletionHandler?()
            self.savedCompletionHandler = nil
        }
    }
}

extension FeedViewModel: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            // handle failure here
            print("\(error.localizedDescription)")
        }
    }
}

extension FeedViewModel: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            let data = try Data(contentsOf: location)
            
            do {
                let feedsDecode = try JSONDecoder().decode([FeedItem].self, from: data)
                self.feedItems = feedsDecode
                
                self.savedCompletionHandler?()
            } catch let error {
                print(error)
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
