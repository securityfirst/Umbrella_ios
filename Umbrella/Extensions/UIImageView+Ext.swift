//
//  UIImageView+Ext.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

extension UIImageView {
    
    //
    // MARK: - Functions
    
    /// Set image with UrlString
    ///
    /// - Parameter url: String
    func setImage(withUrl url: String) {
        ImageDownload.shared.downloadImageFrom(urlString: url) { (image) in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    /// Set image with UrlString
    ///
    /// - Parameter url: String
    func setImage(withUrl url: URL) {
        ImageDownload.shared.downloadImageFrom(url: url) { (image) in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
