//
//  InputFileReader.swift
//  Gilt
//
//  Created by Lucas Correa on 13/08/2017.
//  Copyright © 2017 SiriusCode. All rights reserved.
//

import Foundation

class InputFileReader {
    
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

enum InputFileReaderError: Error {
    case inputFileNotFound
    case invalidFileFormat
}
