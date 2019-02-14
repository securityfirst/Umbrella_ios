//
//  LessonNavigation.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/02/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation
import UIKit

class LessonNavigation: DeepLinkNavigationProtocol {
    
    //
    // MARK: - Properties
    let categoryName: String?
    let difficultyNumber: String?
    
    lazy var segmentViewModel: SegmentViewModel = {
        let segmentViewModel = SegmentViewModel()
        return segmentViewModel
    }()
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameters:
    ///   - categoryName: String
    ///   - content: String
    init(categoryName: String?, difficultyNumber: String?) {
        self.categoryName = categoryName
        self.difficultyNumber = difficultyNumber
    }
    
    //
    // MARK: - Functions
    
    /// Go to screen
    func goToScreen() {
        let dic = searchObject()
        openViewController(dic: dic)
    }
    
    /// Search for the category of the deep link
    ///
    /// - Returns: [String: Category]
    func searchObject() -> [String: Category] {
        //Searching for name of category
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        
        var subCategoryFound = Category()
        var difficultyFound = Category()
        
        if let language = language {
            //Category
            for category in language.categories {
                //Subcategory
                for subCategory in category.categories {
                    let normalizeCategory = subCategory.name?.replacingOccurrences(of: " ", with: "-").lowercased()
                    if self.categoryName == normalizeCategory {
                        subCategoryFound = subCategory
                        validateRuleOfDifficulty(subCategory, subCategoryFound, &difficultyFound)
                        break
                    }
                }
            }
        }
        
        return ["category": subCategoryFound, "difficulty":difficultyFound]
    }
    
    /// Validate the rule of difficulty
    ///
    /// - Parameters:
    ///   - subCategory: Category
    ///   - subCategoryFound: Category
    ///   - difficultyFound: Category
    fileprivate func validateRuleOfDifficulty(_ subCategory: Category, _ subCategoryFound: Category, _ difficultyFound: inout Category) {
        // Verify the rule of difficulty if it does not exist do an insert on the database
        var difficultyRule = DifficultyRule()
        var difficultyId = -1
        
        if let difficultyNumber = self.difficultyNumber, difficultyNumber.count > 0 {
            let difficulty = subCategory.categories[Int(difficultyNumber) ?? 0]
            difficultyRule = DifficultyRule(categoryId: difficulty.parent, difficultyId: difficulty.id)
            difficultyId = difficulty.id
            self.segmentViewModel.insert(difficultyRule)
        } else {
            difficultyRule = DifficultyRule(categoryId: subCategoryFound.id)
            difficultyId = self.segmentViewModel.isExistRule(to: difficultyRule)
        }
        
        // Do not exist
        if difficultyId == -1 {
            difficultyFound = subCategory.categories[0]
            difficultyRule.difficultyId = difficultyFound.id
            self.segmentViewModel.insert(difficultyRule)
        } else {
            let categoryFilter = subCategory.categories.filter { $0.id == difficultyId }.first
            if let categoryFilter = categoryFilter {
                difficultyFound = categoryFilter
            }
        }
    }
    
    /// Open the specific view controller
    ///
    /// - Parameter dic: [String: Category]
    func openViewController(dic: [String: Category]) {
        
        let subCategoryFound = dic["category"]
        let difficultyFound = dic["difficulty"]
        
        if let subCategoryFound = subCategoryFound, let difficultyFound = difficultyFound, subCategoryFound.id != -1 && difficultyFound.id != -1 {
            let storyboard = UIStoryboard(name: "Lesson", bundle: Bundle.main)
            let viewController = (storyboard.instantiateViewController(withIdentifier: "SegmentViewController") as? SegmentViewController)!
            viewController.segmentViewModel.subCategory = subCategoryFound
            viewController.segmentViewModel.difficulty = difficultyFound
            viewController.segmentViewModel.difficulties = subCategoryFound.categories
            
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
            if appDelegate.window?.rootViewController is UITabBarController {
                let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
                tabBarController.selectedIndex = 3
                if tabBarController.selectedViewController is UINavigationController {
                    let navigationController = (tabBarController.selectedViewController as? UINavigationController)!
                    navigationController.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}
