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
    func clone(witUrl: String, completion: @escaping ((Int, Int) -> Void), failure: @escaping ((Error) -> Void)) {
        
        //Remove folder before a clone
        removeFolder()
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        
        let url: URL = URL(string: witUrl)!
        Repository.clone(from: url, to: documentsUrl.first!, localClone: true, bare: false, credentials: .default, checkoutStrategy: CheckoutStrategy.Force) { (_, totalBytesWritten, totalBytesExpectedToWrite) in
            completion(totalBytesWritten, totalBytesExpectedToWrite)
            }.analysis(ifSuccess: { _ in },
                       ifFailure: {error in
                        print(error)
                        failure(error)
            })
    }
}

extension GitManager {
    
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
