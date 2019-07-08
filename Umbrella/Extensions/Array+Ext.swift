//
//  Array+Ext.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

//Protocal that copyable class should conform
protocol Copying {
    init(original: Self)
}

//Concrete class extension
extension Copying {
    func copy() -> Self {
        return Self.init(original: self)
    }
}

//Array extension for elements conforms the Copying protocol
extension Array where Element: Copying {
    func clone() -> Array {
        var copiedArray = [Element]()
        for element in self {
            copiedArray.append(element.copy())
        }
        return copiedArray
    }
}

extension Array {
    
    /// Search for a list recursive the folderName and return the category with same path
    ///
    /// - Parameter folderName: path of file
    /// - Return: a category
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
    
    /// Remove object
    ///
    /// - Parameter obj: Object
    mutating func removeObject<T>(obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }
    
    func indexExists(_ index: Int) -> Bool {
        return self.indices.contains(index)
    }
}
