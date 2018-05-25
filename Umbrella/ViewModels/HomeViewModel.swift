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
    
    func parseTent() -> String {
        var mark: String = ""
        //Category
        var categoryParse = CategoryParse(documentsFolder: documentsFolder)
        categoryParse.parse(completion: { title, index, parent, categoryFolder in
            print("Category: \(title) \(index) \(parent)")
            
            //SubCategory
            let subCategoryParse = SubCategoryParse(categoryFolder: categoryFolder)
            subCategoryParse.parse(completion: { title, index, parent, difficultyFolder in
                print("SubCategory: \(title) \(index) \(parent)")
                
                //Difficulty
                let difficultyParse = DifficultyParse(subCategoryFolder: difficultyFolder)
                difficultyParse.parse(completion: { title, index, description in
                    print("Difficulty: \(title) \(index) \(description)")
                })
                
                //Segment
                let segmentParse = SegmentParse(subCategoryFolder: difficultyFolder)
                segmentParse.parse(completion: { segments in
                
                    for (title, index, markdown) in segments {
                        print("Segment: \(index) \(title)")
                        // FIXME: Test of markdown
                        mark = markdown
                    }
                })
            })
        })
        
        return mark
    }
    
    func clone(completion: @escaping (Float) -> Void) {
        DispatchQueue.global(qos: .background).async {
            GitManager.shared.clone(witUrl: kGitBaseURL, completion: { (totalBytesWritten, totalBytesExpectedToWrite) in
                let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
                completion(progress)
            }, failure: { error in
                print(error)
            })
        }
    }
}
