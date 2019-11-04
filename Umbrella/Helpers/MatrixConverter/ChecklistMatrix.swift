//
//  ChecklistMatrix.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/08/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation
import UIKit

struct ChecklistMatrix: MatrixConverterProtocol {
    
    var matrixFile: MatrixFile
    var isUserLogged: Bool
    var userMatrix: String
    var category: String
    var subCategory: String
    var difficulty: String
    var checklistId: String
    
    var matrixConverterViewModel: MatrixConverterViewModel!

    init(matrixFile: MatrixFile, isUserLogged: Bool, userMatrix: String) {
        self.matrixFile = matrixFile
        self.isUserLogged = isUserLogged
        self.matrixConverterViewModel = MatrixConverterViewModel()
        self.category = ""
        self.subCategory = ""
        self.difficulty = ""
        self.checklistId = ""
        self.userMatrix = userMatrix
    }
    
    fileprivate func insertDB(_ checklistMatrixFile: CheckList, _ checklistDB: CheckList?, _ subCategoryDB: Category?, _ difficultyDB: Category?, _ languageDB: Language?) {
        for checkitem in checklistMatrixFile.items where checkitem.answer == 1 {
            checklistDB?.items.forEach({ (item) in
                if item.name == checkitem.name {
                    
                    // Here we have id item we can insert into the database or return id
                    print(item.name)
                    print(item.id)
                    
                    let checklistChecked = ChecklistChecked(subCategoryName: subCategoryDB!.name ?? "", subCategoryId: subCategoryDB!.id, difficultyId: difficultyDB!.id, checklistId: checklistDB!.id, itemId: item.id, totalItemsChecklist: checklistDB!.countItemCheck(), isMatrix: 1, userMatrix: self.userMatrix)
                    checklistChecked.languageId = languageDB!.id
                    self.matrixConverterViewModel.insertChecklistChecked(checklistChecked)
                }
            })
        }
    }
    
    mutating func updateDB() {
        print("Checklist UpdateDB")
        
        let languages = UmbrellaDatabase.languagesStatic
        
        //ChecklistMatrix with answers
        let checklistMatrixFile = (matrixFile.object as? CheckList)!
        
        //Language
        let languageDB = languages.filter { $0.name == matrixFile.language }.first
        
        // Subcategory
        let subCategoryDB = searchCategoryBy(language: languageDB!, nameCategory: matrixFile.name)
        self.subCategory = subCategoryDB?.deeplink ?? ""
        
        // Category
        let categoryDB = languageDB?.categories.first(where: { $0.id == subCategoryDB?.parent })
        self.category = categoryDB?.deeplink ?? ""
        
        // Difficulty
        let difficultyDB = subCategoryDB?.searchCategoryBy(name: matrixFile.extra)
        self.difficulty = difficultyDB?.deeplink ?? ""
        
        // Checklist
        let checklistDB = difficultyDB?.checkLists.first
        self.checklistId = "\(checklistDB?.id ?? 0)"
        
        let checklistChecked = self.matrixConverterViewModel.listOfChecklistChecked(byChecklistId: checklistDB?.id ?? -1)
        
        if checklistChecked.count == 0 {
            insertDB(checklistMatrixFile, checklistDB, subCategoryDB, difficultyDB, languageDB)
        }
    }
    
    func openFile() {
        print("Checklist Open File")
        //set checklist tab afterward open url
        //umbrella://information/managing-information/beginner/checklist/65
        
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        if appDelegate.window?.rootViewController is UITabBarController {
            let tabBarController = (appDelegate.window?.rootViewController as? UITabBarController)!
            tabBarController.selectedIndex = 2
            let url = URL(string: "umbrella://\(category)/\(subCategory)/\( difficulty)/checklist/\(checklistId)")
            UIApplication.shared.open(url!)
        }
    }
    
    /// Search recursive for whole the categories
    ///
    /// - Parameter id: Int
    /// - Returns: Category?
    func searchCategoryBy(language: Language, nameCategory: String) -> Category? {
        for cat in language.categories {
            let found = cat.searchCategoryBy(name: nameCategory)
            if (found != nil) {
                return found
            }
        }
        return nil
    }
    
    /// Search recursive for whole the categories
    ///
    /// - Parameter id: Int
    /// - Returns: Category?
    func searchCategoryBy(parent: Category?, nameCategory: String) -> Category? {
        let found = parent?.searchCategoryBy(name: nameCategory)
        if (found != nil) {
            return found
        }
        return nil
    }
}
