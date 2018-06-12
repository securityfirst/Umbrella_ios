//
//  GitManager.swift
//  Umbrella
//
//  Created by Lucas Correa on 23/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SwiftGit2
import Result

class GitManager {
    
    //
    // MARK: - Singleton
    static let shared: GitManager = {
        let gitManager = GitManager()
        return gitManager
    }()
    
    //
    // MARK: - Functions
    
    /// Clone of repository
    ///
    /// - Parameters:
    ///   - witUrl: url of repository
    ///   - completion: return totalBytesWritten, totalBytesExpectedToWrite
    ///   - failure: return error
    func clone(witUrl: String, completion: @escaping ((Float, Float) -> Void), failure: @escaping ((Error) -> Void)) {
        
        //Remove folder before a clone
        if !debug {
            removeFolder()
            
            let fileManager = FileManager.default
            let documentsUrl = fileManager.urls(for: .documentDirectory,
                                                in: .userDomainMask)
            let url: URL = URL(string: witUrl)!
            
            //Create a clone of the Tent
            Repository.clone(from: url, to: documentsUrl.first!, localClone: true, bare: false, credentials: .default, checkoutStrategy: CheckoutStrategy.Force) { (_, totalBytesWritten, totalBytesExpectedToWrite) in
                completion(Float(totalBytesWritten), Float(totalBytesExpectedToWrite))
                }.analysis(ifSuccess: { result in
                   print(result)
                }, ifFailure: {error in
                            print(error)
                            failure(error)
                })
        } else {
            completion(1,1)
        }
    }
}

extension GitManager {
    
    //
    // MARK: - Functions Extension
    
    /// Remove all directory recusively
    fileprivate func removeFolder() {
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        do {
            let filePaths = try fileManager.contentsOfDirectory(at: documentsUrl.first!, includingPropertiesForKeys: nil)
            
            for filePath in filePaths {
                try fileManager.removeItem(atPath: filePath.relativePath)
            }
        } catch {
            print("Could not clear folder: \(error)")
        }
    }
}
