//
//  DifficultyParse.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yaml

struct DifficultyParse {
    let subCategoryFolder: Folder
    
    init(subCategoryFolder: Folder) {
        self.subCategoryFolder = subCategoryFolder
    }
    
    func parse(completion: (String, Int, String) -> Void) {
        var title: String = ""
        var index: Int = 0
        var description: String = ""
        
        do {
            try subCategoryFolder.makeSubfolderSequence(recursive: false).forEach { difficultyFolder in
                
                try difficultyFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { difficultyFile in
                    
                    if difficultyFile.extension == "yml" {
                        let value = try Yaml.load(difficultyFile.readAsString())
                        if difficultyFile.name == ".category.yml" {
                            if let tit = value["title"].string {
                                title = tit
                            }
                            
                            if let ind = value["index"].int {
                                index = ind
                            }
                            
                            if let desc = value["description"].string {
                                description = desc
                            }
                        }
                    }
                }
                
                completion(title, index, description)
            }
        } catch {
            print(error)
        }
    }
}
