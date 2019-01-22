//
//  Html.swift
//  Umbrella
//
//  Created by Lucas Correa on 22/01/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class HTML: ExportProtocol {
    
    //
    // MARK: - Properties
    let nameFile: String!
    let content: String!
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameters:
    ///   - nameFile: String
    ///   - content: String
    init(nameFile: String, content: String) {
        self.nameFile = nameFile
        self.content = content
    }
    
    /// Create File export
    ///
    /// - Returns: URL
    func createExport() -> URL {
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent(self.nameFile)
                try self.content.write(to: fileURL, atomically: false, encoding: .utf8)
                
                return fileURL
            }
        } catch {
            print("error:", error)
        }
        
        return URL(string: "")!
    }
}
