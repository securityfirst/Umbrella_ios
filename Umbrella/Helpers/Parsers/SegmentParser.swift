//
//  SegmentParser.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files
import Yams

struct SegmentParser {
    
    //
    // MARK: - Properties
    let folder: Folder
    let file: File
    let array: [Language]
    
    //
    // MARK: - Initializers
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - folder: folder of category
    ///   - file: file of parse
    ///   - array: list of language
    init(folder: Folder, file: File, list: [Language]) {
        self.folder = folder
        self.file = file
        self.array = list
    }
    
    //
    // MARK: - Functions
    
    /// Parse of the Segment
    func parse() {
        
        do {
            var segment: Segment?
            
            let fileString = try file.readAsString()
            var lines = fileString.components(separatedBy: "\n")
            
            // Get Header are 4 lines
            var headerLines: [String] = []
            removeHeader(&lines, &headerLines)
            
            //Title and Index of the Segment
            if let first = headerLines.first, let last = headerLines.last {
                let header = first + "\n" + last
                segment = try YAMLDecoder().decode(Segment.self, from: header)
            }
            
            //List of the Segments
            var markdown: String = ""
            let path: String = (folder.path.components(separatedBy: "Documents").last)!
            
            for line in lines {
                var lineReplaced = ""
                if line.contains("![image](") {
                    lineReplaced = line.replacingOccurrences(of: "![image](", with: "![image](#DOCUMENTS\(path)") + "\n"
                } else if line.contains("![](") {
                    lineReplaced = line.replacingOccurrences(of: "![](", with: "![](#DOCUMENTS\(path)") + "\n"
                } else {
                    lineReplaced = line
                }
                markdown += lineReplaced + "\n "
            }
            
            segment?.content = markdown
            segment?.file = file.name
            
            if let object = array.searchParent(folderName: folder.path) {
                let category = object as? Category
                category?.segments.append(segment!)
            }
            
        } catch {
            print("SegmentParser: \(error)")
        }
    }
    
    /// Remove the header of the file
    ///
    /// - Parameters:
    ///   - lines: array of lines
    ///   - headerLines: array to store the header
    fileprivate func removeHeader(_ lines: inout [String], _ headerLines: inout [String]) {
        var count = 0
        for item in lines {
            
            if count == 2 {
                break
            }
            
            if item.contains("---") {
                count+=1
                lines.remove(at: 0)
            } else {
                headerLines.append(item)
                lines.remove(at: 0)
            }
        }
    }
}
