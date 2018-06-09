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
    
    //
    // MARK: - Property
    let categoryFolder: Folder
    
    //
    // MARK: - Init
    init(categoryFolder: Folder) {
        self.categoryFolder = categoryFolder
    }
    
    //
    // MARK: - Functions    
    
    /// Function to parse of folder relative the Subcategory
    ///
    /// - parameter completion: A closure to call
    /// - parameter title: Name of Subcategory
    /// - parameter index: Index for sorting the position of the subCategories
    /// - parameter parent: Name of parent directory
    /// - parameter folder: directory of subCategory
    func parse(completion: (_ title: String, _ index: Int, _ parent: String, _ folder: Folder) -> Void) {
        var title: String = ""
        var index: Int = 0
        var parent: String = ""
        
        do {
            try categoryFolder.makeSubfolderSequence(recursive: false).forEach { subCategoryFolder in
                try subCategoryFolder.makeFileSequence(recursive: false, includeHidden: true).forEach { file in
                    
                    if file.extension == "yml" {
                        let value = try Yaml.load(file.readAsString())
                        
                        if let tit = value["title"].string {
                            title = tit
                        }
                        
                        if let ind = value["index"].int {
                            index = ind
                        }
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
