//
//  HomeViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SwiftGit2
import Result

class HomeViewModel {
    
    //
    // MARK: - Functions
    func parseTent() -> String {
        var mark: String = ""
        
        //Language
        var languageParse = LanguageParse(documentsFolder: documentsFolder)
        languageParse.parse { title, _, _, languageFolder in
            
//            //Category
//            var categoryParse = CategoryParse(languageFolder: languageFolder)
//            categoryParse.parse { title, index, parent, categoryFolder in
//                print("Category: \(title) \(index) \(parent)")
                
//                //SubCategory
//                let subCategoryParse = SubCategoryParse(categoryFolder: categoryFolder)
//                subCategoryParse.parse { title, index, parent, subCategoryFolder in
//                    print("SubCategory: \(title) \(index) \(parent)")
//
//                    //Difficulty
//                    let difficultyParse = DifficultyParse(subCategoryFolder: subCategoryFolder)
//                    difficultyParse.parse { title, index, description, folder in
//                        print("Difficulty: \(title) \(index) \(description) Subcategory: \(folder.name)")
//                    }
//
//                    //Segment
//                    let segmentParse = SegmentParse(subCategoryFolder: subCategoryFolder)
//                    segmentParse.parse { segments, folder in
//
//                        for (title, index, markdown) in segments {
//                            print("Segment: \(index) \(title) Subcategory: \(folder.name)")
//                            // FIXME: Test of markdown
//                            mark = markdown
//                        }
//                    }
//                }
//            }
        }
        
        return mark
    }
    
    func clone(witUrl url: String, completion: @escaping (Float) -> Void) {
        DispatchQueue.global(qos: .background).async {
            GitManager.shared.clone(witUrl: url, completion: { (totalBytesWritten, totalBytesExpectedToWrite) in
                let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
                completion(progress)
            }, failure: { error in
                print(error)
            })
        }
    }
}
