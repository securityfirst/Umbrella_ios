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
import Yams

struct DifficultyParse {
    
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
    
    /// Function to parse of folder relative the Difficulty
    ///
    /// - parameter completion: A closure to call
    /// - parameter title: Name of difficulty
    /// - parameter index: Index for sorting the position of the difficulty
    /// - parameter description: Description of difficulty
    func parse(completion: (_ title: String, _ index: Int, _ description: String, _ folder: Folder) -> Void) {
        var title: String = ""
        var index: Int = 0
        var description: String = ""
        
        do {
            try subCategoryFolder.makeSubfolderSequence(recursive: false).forEach { difficultyFolder in
                try difficultyFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { difficultyFile in
                    
                    if difficultyFile.extension == "yml" {
                        
                        struct Sample: Codable {
                            let test: Int
                            let array: [[String:String]]
                            enum CodingKeys: String, CodingKey {
                                case test = "index"
                                case array = "list"
                            }
                        }
                        
                        if difficultyFile.name == ".category.yml" {
                            let value = try Yaml.load(difficultyFile.readAsString())
                            if let tit = value["title"].string {
                                title = tit
                            }
                            
                            if let ind = value["index"].int {
                                index = ind
                            }
                            
                            if let desc = value["description"].string {
                                description = desc
                            }
                        } else {
//                            print("CheckList: \(difficultyFile.name)")
//                            print(try difficultyFile.readAsString())
//                            let ddd = try YAMLDecoder().decode(Sample.self, from: difficultyFile.readAsString())
//                            let d2 = try YAMLDecoder().decode(from: difficultyFile.readAsString())
//                            print(ddd)
                        }
                    }
                }
                completion(title, index, description, difficultyFolder)
            }
        } catch {
            print(error)
        }
    }
}
