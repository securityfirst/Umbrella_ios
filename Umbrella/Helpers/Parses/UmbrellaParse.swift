//
//  UmbrellaParse.swift
//  Umbrella
//
//  Created by Lucas Correa on 31/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yams

struct UmbrellaParse {
    
    //
    // MARK: - Properties
    let documentsFolder: Folder
    
    //
    // MARK: - Init
    init(documentsFolder: Folder) {
        self.documentsFolder = documentsFolder
    }
    
    //
    // MARK: - Functions
    
    /// Parse of tent
    ///
    /// - Parameter completion: return languages and forms
    func parse(completion: ([Language], [Form]) -> Void) {
        var languageArray =  [Language]()
        var formArray =  [Form]()
        
        //Languages
        self.documentsFolder.makeSubfolderSequence(recursive: false).forEach { languageFolder in
            
            //Create a language
            let language: Language = Language(name: languageFolder.name)
            language.folderName = languageFolder.path
            languageArray.append(language)
            
            //Categories recursive
            languageFolder.makeSubfolderSequence(recursive: true).forEach { categoryFolder in
                
                if categoryFolder.name != "forms" {
                    categoryFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { file in
                        
                        // Category Parse
                        if file.type == .category {
                            let categoryParse = CategoryParse(folder: categoryFolder, file: file, array: languageArray)
                            categoryParse.parse()
                        }
                            
                            // CheckList Parse
                        else if file.type == .checkList {
                            let checkListParse = CheckListParse(folder: categoryFolder, file: file, array: languageArray)
                            checkListParse.parse()
                        }
                            
                            // Segment Parse
                        else if file.type == .segment {
                            let segmentParse = SegmentParse(folder: categoryFolder, file: file, array: languageArray)
                            segmentParse.parse()
                        }
                    }
                } else {
                    categoryFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { file in
                        
                        // Form Parse
                        if file.name != ".category.yml" {
                            var formParse = FormParse(file: file)
                            if let form = formParse.parse() {
                                formArray.append(form)
                            }
                        }
                    }
                }
            }
        }
        
        completion(languageArray, formArray)
    }
}
