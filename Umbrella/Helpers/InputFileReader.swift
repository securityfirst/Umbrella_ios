//
//  InputFileReader.swift
//  Umbrella
//
//  Created by Lucas Correa on 18/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

enum InputFileReaderError: Error {
    case inputFileNotFound
    case invalidFileFormat
}

class InputFileReader {
    
    //
    // MARK: - Functions
    
    /// Read file
    ///
    /// - Parameter fileName: name of file
    /// - Returns: return content of file in string
    /// - Throws: error
    func readFileAt(_ fileName: String) throws -> String {
        guard let path = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "") else {
            throw InputFileReaderError.inputFileNotFound
        }
        
        guard let content = try? String(contentsOfFile: path) else {
            throw InputFileReaderError.invalidFileFormat
        }
        return content
    }
}
