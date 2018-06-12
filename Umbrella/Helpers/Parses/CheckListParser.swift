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
    // MARK: - Init
    
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
    
    /// Parse of CheckList
    func parse() {
        do {
            let checkItem = try YAMLDecoder().decode(CheckList.self, from: file.readAsString())
            
            if let object = array.searchParent(folderName: folder.path) {
                let categ = object as? Category
                categ?.checkList.append(checkItem)
            }
        } catch {
            print(error)
        }
    }
}
