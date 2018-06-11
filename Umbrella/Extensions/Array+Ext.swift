//
//  Array+Ext.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

extension Array {
    
    /// Search for a list recursive the folderName and return the category with same path
    ///
    /// - Parameter folderName: path of file
    /// - Returns: a category
    func searchParent(folderName: String) -> Any? {
        for view in self {
            
            let folder = view as? FolderProtocol
            
            if folder?.folderName == folderName {
                return view
            }
            
            let result = folder?.categories.searchParent(folderName: folderName)
            
            if result != nil {
                return result
            }
        }
        
        return nil
    }
}
