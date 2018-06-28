//
//  String+Ext.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

extension String: Error {
    
}

extension String {
    
    /// Convert String to base64
    ///
    /// - Returns: Base64
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    /// Convert base64 to String
    ///
    /// - Returns: String
    func toBase64() -> String {
        guard let data = self.data(using: String.Encoding.utf8) else {
            return ""
        }
        
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
}
