//
//  SegmentParse.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yaml

struct SegmentParse {
    let subCategoryFolder: Folder
    
    init(subCategoryFolder: Folder) {
        self.subCategoryFolder = subCategoryFolder
    }
    
    func parse(completion: ([(String, Int, String)]) -> Void) {
        var title: String = ""
        var index: Int = 0
        var markdown: String = ""
        var array: [(String, Int, String)] = []
        do {
            
            try subCategoryFolder.makeSubfolderSequence(recursive: false).forEach { difficultyFolder in
                
                try difficultyFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { difficultyFile in
                    if difficultyFile.extension == "md" {
                      
                        let fileString = try difficultyFile.readAsString()
                        
                        var lines = fileString.components(separatedBy: "\n")
                        
                        var headerLines = lines.prefix(4)
                        headerLines.removeFirst(1)
                        headerLines.removeLast()
                        
                        if let first = headerLines.first, let last = headerLines.last {
                            let header = first + "\n" + last
                            let value = try Yaml.load(header)
                            
                            if let tit = value["title"].string {
                                title = tit
                            }
                            
                            if let ind = value["index"].int {
                                index = ind
                            }
                        }
                        
                        lines.removeFirst(4)
                        
                        for line in lines {
                            markdown += line.replacingOccurrences(of: "![image](", with: "![image](\(difficultyFolder.path)") + "\n"
                        }
                        array.append((title, index, markdown))
                    }
                    
                }
                
                completion(array)
            }
        } catch {
            print(error)
        }
        
    }
}
