//
//  SubCategoryParse.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yaml

struct SubCategoryParse {
    let categoryFolder: Folder
    
    init(categoryFolder: Folder) {
        self.categoryFolder = categoryFolder
    }
    
    func parse(completion: (String, Int, String, Folder) -> Void) {
        var title: String = ""
        var index: Int = 0
        var parent: String = ""
        
        do {
            
            try categoryFolder.makeSubfolderSequence(recursive: false).forEach { subCategoryFolder in
                
                try subCategoryFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { file in
                    let value = try Yaml.load(file.readAsString())
                    
                    if let tit = value["title"].string {
                        title = tit
                    }
                    
                    if let ind = value["index"].int {
                        index = ind
                    }
                }
                
                if let parentName = subCategoryFolder.parent?.name {
                    parent = parentName
                }
                
                completion(title, index, parent, subCategoryFolder)
            }
        } catch {
            print(error) 
        }
        
    }
}
