//
//  FormParser.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yams

struct FormParser {
    
    //
    // MARK: - Properties
    let folder: Folder
    let file: File
    
    //
    // MARK: - Initializers
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - file: file of parse
    init(folder: Folder, file: File) {
        self.folder = folder
        self.file = file
    }
    
    //
    // MARK: - Functions
    
    /// Parse of Form
    ///
    /// - Returns: A form
    mutating func parse() -> Form? {
        do {
            let form = try YAMLDecoder().decode(Form.self, from: self.file.readAsString())
            
            let split = folder.path.components(separatedBy: "/")
            
            // Get language
            form.language = split[split.count-3]
            form.file = self.file.name
            return form
        } catch {
            print("FormParser: \(error)")
        }
        
        return nil
    }
}
