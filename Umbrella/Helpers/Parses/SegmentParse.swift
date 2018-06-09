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
    
    //
    // MARK: - Property
    let subCategoryFolder: Folder
    
    //
    // MARK: - Init
    init(subCategoryFolder: Folder) {
        self.subCategoryFolder = subCategoryFolder
    }
    
    //
    // MARK: - Functions
    
    /// Function to parse of folder relative the Segment
    ///
    /// - parameter completion: A closure to call
    /// - parameter title: Name of segment
    /// - parameter index: Index for sorting the position of the segments
    /// - parameter markdown: Detail of markdown
    func parse(completion: ([(title: String, index: Int, markdown: String)], Folder) -> Void) {
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
                        
                        // Get Header are 4 lines
                        var headerLines = lines.prefix(4)
                        headerLines.removeFirst(1)
                        headerLines.removeLast()
                        
                        //Title and Index of the Segment
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
                        
                        //List of the Segments
                        lines.removeFirst(4)
                        for line in lines {
                            markdown += line.replacingOccurrences(of: "![image](", with: "![image](\(difficultyFolder.path)") + "\n"
                        }
                        array.append((title, index, markdown))
                    }
                }
                completion(array, difficultyFolder)
            }
        } catch {
            print(error)
        }
    }
}
