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

struct CategoryParse {
    
    let documentsFolder: Folder
    var categoryFolder: Folder?
    
    init(documentsFolder: Folder) {
        self.documentsFolder = documentsFolder
    }
    
    mutating func parse(completion: (String, Int, String, Folder) -> Void) {
        var title: String = ""
        var index: Int = 0
        
        do {
            
            try documentsFolder.makeSubfolderSequence(recursive: false).forEach { categoryFolder in

                self.categoryFolder = categoryFolder
                
                try categoryFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { file in
                    
                    let value = try Yaml.load(file.readAsString())
                    
                    if let tit = value["title"].string {
                        title = tit
                    }
                    
                    if let ind = value["index"].int {
                        index = ind
                    }
                    
                }
                
                completion(title, index, "", categoryFolder)
            }
        } catch {
            print(error)
        }
        
    }
}
