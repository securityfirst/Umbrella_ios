//
//  CheckListParser.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yams

struct CheckListParser {
    
    //
    // MARK: - Properties
    let folder: Folder
    let file: File
    let array: [Language]
    
    //
    // MARK: - Initializers
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - folder: folder of category
    ///   - file: file of parse
    ///   - array: list of language
    init(folder: Folder, file: File, list: [Language]) {
        self.folder = folder
        self.file = file
        self.array = list
    }
    
    //
    // MARK: - Functions
    
    /// Parse of the CheckList
    func parse() {
        do {
            let checkItem = try YAMLDecoder().decode(CheckList.self, from: file.readAsString())
//            checkItem.name = normalized(name: file.name)
            
            if let object = array.searchParent(folderName: folder.path) {
                let categ = object as? Category
                categ?.checkLists.append(checkItem)
            }
        } catch {
            print("File: \(file.path)")
            print("CheckListParser: \(error)")
        }
    }
    
    fileprivate func normalized(name: String) -> String {
        let nameNormalized = name.replacingOccurrences(of: "c_", with: "").replacingOccurrences(of: "-", with: " ").replacingOccurrences(of: ".yml", with: "")
        
        return nameNormalized.capitalized
    }
}
