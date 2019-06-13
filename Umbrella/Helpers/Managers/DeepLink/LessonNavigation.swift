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
    let category: String?
    let subCategory: String?
    let difficulty: String?
    let file: String?
    let checklistId: String?
    
    lazy var segmentViewModel: SegmentViewModel = {
        let segmentViewModel = SegmentViewModel()
        return segmentViewModel
    }()
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameters:
    ///   - category: String?
    ///   - subCategory: String?
    ///   - difficulty: String?
    ///   - file: String?
    init(category: String?, subCategory: String?, difficulty: String?, file: String?) {
        self.category = category
        self.subCategory = subCategory
        self.difficulty = difficulty
        self.file = file
        self.checklistId = nil
    }
    
    /// Init
    ///
    /// - Parameters:
    ///   - category: String?
    ///   - subCategory: String?
    ///   - difficulty: String?
    ///   - checklistId: String?
    init(category: String?, subCategory: String?, difficulty: String?, file: String?, checklistId: String?) {
        self.category = category
        self.subCategory = subCategory
        self.difficulty = difficulty
        self.file = file
        self.checklistId = checklistId
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
    func searchObject() -> [String: Any] {
        //Searching for name of category
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        
        var subCategoryFound = Category()
        var difficultyFound = Category()
        var segmentFound = Segment()
        var checklistFound = CheckList()
        
        if let language = language {
            //Category
            for category in language.categories where category.deeplink == self.category {
                // if glossary for example umbrella://glossary/s_two-factor-authentication.md
                if self.subCategory == nil && self.difficulty == nil {
                    //Segment - File
                    if (self.file != nil) {
                        let result = category.segments.filter { $0.file == self.file }
                        
                        if let segment = result.first {
                            segmentFound = segment
                        }
                    }
                }
                
                //Subcategory
                for subCategory in category.categories where self.subCategory == subCategory.deeplink {
                    subCategoryFound = subCategory
                    validateRuleOfDifficulty(subCategory, subCategoryFound, &difficultyFound)
                    
                    //Segment - File
                    if (self.file != nil) {
                        let searchCategory = (difficultyFound.id > -1) ? difficultyFound : subCategory
                        let result = searchCategory.segments.filter { $0.file == self.file }
                        
                        if let segment = result.first {
                            segmentFound = segment
                        }
                    }
                    
                    if (self.checklistId != nil) {
                        if let checklistId = self.checklistId {
                            let result = difficultyFound.checkLists.filter { $0.id == Int(checklistId) }
                            if let checklist = result.first {
                                checklistFound = checklist
                            }
                        }
                    }
                    
                    break
                }
                break
            }
        }
        
        return ["category": subCategoryFound, "difficulty":difficultyFound, "segment": segmentFound, "checklist": checklistFound]
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
        
        if getDifficulty() >= 0 {
            let difficulty = subCategory.categories.filter { $0.name?.lowercased() == self.difficulty?.lowercased() }.first
            if let difficulty = difficulty {
                difficultyRule = DifficultyRule(categoryId: difficulty.parent, difficultyId: difficulty.id)
                difficultyId = difficulty.id
                self.segmentViewModel.insert(difficultyRule)
            }
        } else {
            difficultyRule = DifficultyRule(categoryId: subCategoryFound.id)
            difficultyId = self.segmentViewModel.isExistRule(to: difficultyRule)
        }
        
        // Do not exist
        if difficultyId == -1 {
            if subCategory.categories.count > 0 {
                difficultyFound = subCategory.categories[0]
                difficultyRule.difficultyId = difficultyFound.id
                self.segmentViewModel.insert(difficultyRule)
            }
        } else {
            let categoryFilter = subCategory.categories.filter { $0.id == difficultyId }.first
            if let categoryFilter = categoryFilter {
                difficultyFound = categoryFilter
            }
        }
    }
    
    func getDifficulty() -> Int {
        
        if self.difficulty?.lowercased() == "Beginner".localized().lowercased() {
            return 0
        } else if self.difficulty?.lowercased() == "Advanced".localized().lowercased() {
            return 1
        } else if self.difficulty?.lowercased() == "Expert".localized().lowercased() {
            return 2
        }
        
        return -1
    }
    
    /// Open the specific view controller
    ///
    /// - Parameter dic: [String: Category]
    func openViewController(dic: [String: Any]) {
        
        let subCategoryFound = dic["category"] as? Category
        let difficultyFound = dic["difficulty"] as? Category
        let segmentFound = dic["segment"] as? Segment
        let checklistFound = dic["checklist"] as? CheckList
        
        if segmentFound?.id != -1 {
            let storyboard = UIStoryboard(name: "Lesson", bundle: Bundle.main)
            let viewController = (storyboard.instantiateViewController(withIdentifier: "ReviewLessonViewController") as? ReviewLessonViewController)!
            viewController.reviewLessonViewModel.segments = ([segmentFound] as? [Segment])!
            viewController.reviewLessonViewModel.selected = segmentFound
            
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
            if appDelegate.window?.rootViewController is UITabBarController {
                let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
//                tabBarController.selectedIndex = 3
                if tabBarController.selectedViewController is UINavigationController {
                    let navigationController = (tabBarController.selectedViewController as? UINavigationController)!
                    navigationController.pushViewController(viewController, animated: true)
                }
            }
        } else  if let subCategoryFound = subCategoryFound, let difficultyFound = difficultyFound, let checklistFound = checklistFound, subCategoryFound.id != -1 && difficultyFound.id != -1 && checklistFound.id != -1 {
            let storyboard = UIStoryboard(name: "Lesson", bundle: Bundle.main)
            let viewController = (storyboard.instantiateViewController(withIdentifier: "ReviewLessonViewController") as? ReviewLessonViewController)!
            
            viewController.reviewLessonViewModel.category = difficultyFound
            viewController.reviewLessonViewModel.segments = difficultyFound.segments
            viewController.reviewLessonViewModel.checkLists = difficultyFound.checkLists
            viewController.reviewLessonViewModel.selected = checklistFound
            
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
            if appDelegate.window?.rootViewController is UITabBarController {
                let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
//                tabBarController.selectedIndex = 3
                if tabBarController.selectedViewController is UINavigationController {
                    let navigationController = (tabBarController.selectedViewController as? UINavigationController)!
                    navigationController.popViewController(animated: false)
                    navigationController.pushViewController(viewController, animated: true)
                }
            }
        } else  if let subCategoryFound = subCategoryFound, let difficultyFound = difficultyFound, subCategoryFound.id != -1 && difficultyFound.id != -1 {
            let storyboard = UIStoryboard(name: "Lesson", bundle: Bundle.main)
            let viewController = (storyboard.instantiateViewController(withIdentifier: "SegmentViewController") as? SegmentViewController)!
            viewController.segmentViewModel.subCategory = subCategoryFound
            viewController.segmentViewModel.difficulty = difficultyFound
            viewController.segmentViewModel.difficulties = subCategoryFound.categories
            
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
            if appDelegate.window?.rootViewController is UITabBarController {
                let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
//                tabBarController.selectedIndex = 3
                if tabBarController.selectedViewController is UINavigationController {
                    let navigationController = (tabBarController.selectedViewController as? UINavigationController)!
                    navigationController.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}
