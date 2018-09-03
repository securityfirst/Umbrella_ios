//
//  ImageDownload.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class ImageDownload {
    
    //
    // MARK: - Properties
    static let shared = ImageDownload()
    var imageURLString: String?
    
    // Just cache local
    let imageCache = NSCache<NSString, AnyObject>()
    
    //
    // MARK: - Functions
    
    /// Download of an image from urlString
    ///
    /// - Parameters:
    ///   - urlString: String
    ///   - completion: closure
    func downloadImageFrom(urlString: String, completion: @escaping (UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }
        downloadImageFrom(url: url, completion: completion)
    }
    
    /// Download of an image from URL
    ///
    /// - Parameters:
    ///   - url: URL
    ///   - completion: closure
    func downloadImageFrom(url: URL, completion: @escaping (UIImage) -> Void) {
        
        // I created this function only to download an image, but It is not perfect. It needs to improve when user there is low internet
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            completion(cachedImage)
        } else {
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data)
                    self.imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
                    completion(imageToCache!)
                }
                }.resume()
        }
    }
}
