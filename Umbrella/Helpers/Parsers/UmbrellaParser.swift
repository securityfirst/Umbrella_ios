//
//  UmbrellaParser.swift
//  Umbrella
//
//  Created by Lucas Correa on 31/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yams

struct UmbrellaParser {
    
    //
    // MARK: - Properties
    let documentsFolder: Folder
    var languageArray =  [Language]()
    var formArray =  [Form]()
    
    //
    // MARK: - Initializers
    init(documentsFolder: Folder) {
        self.documentsFolder = documentsFolder
    }
    
    //
    // MARK: - Functions
    
    /// Parse of the tent
    ///
    /// - Parameter completion: return languages and forms
    mutating func parse(completion: ([Language], [Form]) -> Void) {
        
        //Languages
        self.documentsFolder.makeSubfolderSequence(recursive: false).forEach { languageFolder in
            
            //Create a language
            let language: Language = Language(name: languageFolder.name)
            language.folderName = languageFolder.path
            self.languageArray.append(language)
            
            //Categories recursive
            languageFolder.makeSubfolderSequence(recursive: true).forEach { categoryFolder in
                categoryFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { file in
                    parseOf(folder: categoryFolder, file: file)
                }
            }
        }
        
        completion(languageArray, formArray)
    }
    
    /// Parse to each parser - Category, Segment, CheckList and Form
    ///
    /// - Parameters:
    ///   - folder: folder of category
    ///   - file: file of parse
    fileprivate mutating func parseOf(folder: Folder, file: File) {
        switch file.type {
            
        // Category
        case .category:
            let categoryParser = CategoryParser(folder: folder, file: file, list: self.languageArray)
            categoryParser.parse()
            
        // CheckList
        case .checkList:
            let checkListParser = CheckListParser(folder: folder, file: file, list: self.languageArray)
            checkListParser.parse()
            
        // Segment
        case .segment:
            let segmentParser = SegmentParser(folder: folder, file: file, list: self.languageArray)
            segmentParser.parse()
            
        //Form
        case .form:
            var formParser = FormParser(file: file)
            if let form = formParser.parse() {
                self.formArray.append(form)
            }
            
        case .none:
            break
        }
    }
}
