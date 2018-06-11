//
//  FormParse.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yams

struct FormParse {
    
    //
    // MARK: - Properties
    let file: File
    
    //
    // MARK: - Init
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - file: file of parse
    init(file: File) {
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
            return form
        } catch {
            print(error)
        }
        
        return nil
    }
}
