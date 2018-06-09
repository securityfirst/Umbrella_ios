//
//  LanguageParse.swift
//  Umbrella
//
//  Created by Lucas Correa on 31/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yaml
import Yams

struct LanguageParse {
    
    //
    // MARK: - Property
    let documentsFolder: Folder
    var languageFolder: Folder?
    
    //
    // MARK: - Init
    init(documentsFolder: Folder) {
        self.documentsFolder = documentsFolder
    }
    
    //
    // MARK: - Functions
    
    /// Function to parse of folder relative the Language
    ///
    /// - parameter completion: A closure to call
    /// - parameter title: Name of language
    /// - parameter index: Not applicable
    /// - parameter parent: Not applicable
    /// - parameter folder: folder of language
    mutating func parse(completion: (_ title: String, _ index: Int, _ parent: String, _ folder: Folder) -> Void) {
        var title: String = ""
        var array =  [Language]()
        var language: Language?
        documentsFolder.makeSubfolderSequence(recursive: false).forEach { languageFolder in
            self.languageFolder = languageFolder
            
            title = languageFolder.name
            language = Language(name: title)
            language?.folderName = languageFolder.path
            
            array.append(language!)
            
            do {
                try languageFolder.makeSubfolderSequence(recursive: true).forEach { categoryFolder in
                    
                    
                    print(categoryFolder.name)
                    if categoryFolder.name != "forms" {
                        
                        try categoryFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { file in
                            
                            print(file.name)
                            if file.name == ".category.yml" {
                                
//                                print(try file.readAsString())
                                let category = try YAMLDecoder().decode(Category.self, from: file.readAsString())
                                category.folderName = categoryFolder.path
                                
                                if let object = array.search(folderName: (categoryFolder.parent?.path)!) {
                                    
                                    if object is Language {
                                        let lang = object as? Language
                                        lang?.categories.append(category)
                                    } else if object is Category {
                                        let categ = object as? Category
                                        categ?.categories.append(category)
                                    }
                                    
                                } else {
//                                  print("No match")
                                }
                            } else if file.name == "c_checklist.yml" {
                                
//                                print(try file.readAsString())
                                let checkItem = try YAMLDecoder().decode(CheckItem.self, from: file.readAsString())
                            
                                if let object = array.search(folderName: categoryFolder.path) {
                                    
                                    let categ = object as? Category
//                                    print(categ?.name)
                                    categ?.checkList.append(checkItem)
                                }
//                                print(checkItem)
                            } else if file.extension == "md" {
                                
                                var segment: Segment?
                                
                                let fileString = try file.readAsString()
                                var lines = fileString.components(separatedBy: "\n")
                                
                                // Get Header are 4 lines
                                var headerLines = lines.prefix(4)
                                headerLines.removeFirst(1)
                                headerLines.removeLast()
                                
                                //Title and Index of the Segment
                                if let first = headerLines.first, let last = headerLines.last {
                                    let header = first + "\n" + last
                                    segment = try YAMLDecoder().decode(Segment.self, from: header)
                                }
                                
                                //List of the Segments
                                lines.removeFirst(4)
                                var markdown: String = ""
                                for line in lines {
                                    markdown += line.replacingOccurrences(of: "![image](", with: "![image](\(categoryFolder.path)") + "\n"
                                }
                                
                                segment?.content = markdown
                                
                                if let object = array.search(folderName: categoryFolder.path) {
                                    
                                    let categ = object as? Category
//                                    print(categ?.name)
                                    categ?.segments.append(segment!)
                                }
                            }
                        }
                    }
                }
                
                
            } catch {
                print(error)
            }
        }
        
        print(array ?? "")
//        completion(title, 0, "", "")
    }
}

extension Array {
    func search(folderName: String) -> Any? {
        for view in self {
            
            if view is Language {
                let language = view as? Language
                
                if language?.folderName == folderName {
                    return view
                }
                
                if (language?.categories.count)! > 0 {
                    
                    for cat in (language?.categories)! {
                        if cat.folderName == folderName {
                            return cat
                        } else {
                            
                            for cat2 in cat.categories {
//                                print(cat2.name ?? "")
//                                print(cat2.categories.count)
                                if cat2.folderName == folderName {
                                    return cat2
                                } else {
                                    //                                print("ads")
                                    let ret = cat2.categories.search(folderName: folderName)
                                    
                                    if ret != nil {
                                        return ret
                                    }
                                }
                            }
                        }
                    }
                }
            } else if view is Category {
                
                let category = view as? Category
                
                if category?.folderName == folderName {
                    return category
                } else if (category?.categories.count)! > 0 {
                    
                    for cat in (category?.categories)! {
                        if cat.folderName == folderName {
                            return cat
                        } else {
                            
                            for cat2 in cat.categories {
//                                print(cat2.name ?? "")
//                                print(cat2.categories.count)
                                if cat2.folderName == folderName {
                                    return cat2
                                } else {
                                    //                                print("ads")
                                    let dddd = cat2.categories.search(folderName: folderName)
                                    return dddd
                                }
                            }
                        }
                    }
                }
            }
        }
        
        return nil
    }
}
