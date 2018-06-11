//
//  CategoryParse.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yams

struct CategoryParse {
    
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
    init(folder: Folder, file: File, array: [Language]) {
        self.folder = folder
        self.file = file
        self.array = array
    }
    
    //
    // MARK: - Functions

    /// Parse of category
    func parse() {
        do {
            let category = try YAMLDecoder().decode(Category.self, from: file.readAsString())
            category.folderName = folder.path
            
            if let object = array.searchParent(folderName: (folder.parent?.path)!) {
                
                if object is Language {
                    let lang = object as? Language
                    lang?.categories.append(category)
                } else if object is Category {
                    let categ = object as? Category
                    categ?.categories.append(category)
                }
                
            } else {
                throw "No match"
            }
            
        } catch {
            print(error)
        }
    }
}
