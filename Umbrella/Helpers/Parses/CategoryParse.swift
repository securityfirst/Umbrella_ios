//
//  CategoryParse.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yaml
import Yams

struct CategoryParse {
    
    //
    // MARK: - Property
    let languageFolder: Folder
    var categoryFolder: Folder?
    
    //
    // MARK: - Init
    init(languageFolder: Folder) {
        self.languageFolder = languageFolder
    }
    
    //
    // MARK: - Functions
    
    /// Function to parse of folder relative the Category
    ///
    /// - parameter completion: A closure to call
    /// - parameter title: Name of category
    /// - parameter index: Index for sorting the position of the categories
    /// - parameter parent: Name of parent directory
    /// - parameter folder: directory of category
    mutating func parse(completion: (_ title: String, _ index: Int, _ parent: String, _ folder: Folder) -> Void) {
        var title: String = ""
        var index: Int = 0
        
        var array =  [Category]()
        do {
            try languageFolder.makeSubfolderSequence(recursive: true).forEach { categoryFolder in
                self.categoryFolder = categoryFolder
                
                if categoryFolder.name != "forms" {
                    
                    print("CategoryName: \(categoryFolder.name) \(categoryFolder.parent?.name)")
                    
                    try categoryFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { file in
                        
                        if file.name == ".category.yml" {
                            
                            print(try file.readAsString())
                            let category = try YAMLDecoder().decode(Category.self, from: file.readAsString())
                            
                            array.append(category)
                            
                        } else {
                            print("FileName: \(file.name)")
                        }
                    }
                }
                print("\n")
                completion(title, index, "", categoryFolder)
            }
        } catch {
            print(error)
        }
    }
    
    mutating func parse(ofFolder folder: Folder, completion: (_ title: String, _ index: Int, _ parent: String, _ folder: Folder) -> Void) {
        var title: String = ""
        var index: Int = 0
        
        do {
            try folder.makeSubfolderSequence(recursive: false).forEach { categoryFolder in
                self.categoryFolder = categoryFolder
                
                if categoryFolder.name != "forms" {
                    try categoryFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { file in
                        
                        if file.extension == "yml" {
                            
                            print(try file.readAsString())
                            let ddd = try YAMLDecoder().decode(Category.self, from: file.readAsString())
                            print(ddd)
                            
                            let value = try Yaml.load(file.readAsString())
                            
                            if let tit = value["title"].string {
                                title = tit
                            }
                            
                            if let ind = value["index"].int {
                                index = ind
                            }
                        }
                    }
                }
                completion(title, index, "", categoryFolder)
            }
        } catch {
            print(error)
        }
    }
}
