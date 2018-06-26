//
//  UmbrellaDatabase.swift
//  Umbrella
//
//  Created by Lucas Correa on 25/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct UmbrellaDatabase {
    
    //
    // MARK: - Properties
    let languageDao = LanguageDao()
    let categoryDao = CategoryDao()
    let segmentDao = SegmentDao()
    let checkListDao = CheckListDao()
    let checkItemDao = CheckItemDao()
    let formDao = FormDao()
    let screenDao = ScreenDao()
    let itemFormDao = ItemFormDao()
    let optionItemDao = OptionItemDao()
    let languages: [Language]
    let forms: [Form]
    
    //
    // MARK: - Initializers
    init(languages: [Language], forms: [Form]) {
        self.languages = languages
        self.forms = forms
    }
    
    //
    // MARK: - Functions
    
    /// Convert from object to database
    func objectToDatabase() {
        DispatchQueue.global(qos: .background).async {
            self.createTables()
            self.insertAllLessons()
            self.insertAllForms()
        }
    }
    
    
    /// Convert from database to object
    func databaseToObject() {
        
    }
}

extension UmbrellaDatabase {
    
    /// Create all tables
    fileprivate func createTables() {
        _ = self.languageDao.createTable()
        _ = self.categoryDao.createTable()
        _ = self.segmentDao.createTable()
        _ = self.checkListDao.createTable()
        _ = self.checkItemDao.createTable()
        
        _ = self.formDao.createTable()
        _ = self.screenDao.createTable()
        _ = self.itemFormDao.createTable()
        _ = self.optionItemDao.createTable()
    }
    
    /// Insert all the lessons of languages, categories, segments and checkList
    fileprivate func insertAllLessons() {
        // Language
        for language in self.languages {
            
            let languageRowId = self.languageDao.insert(language)
            
            // To this moment we need to add whole category parent separete of subcategories
            // Categories
            for index in 0..<language.categories.count {
                let category = language.categories[index]
                
                category.languageId = Int(languageRowId)
                let categoryRowId = self.categoryDao.insert(category)
                category.id = Int(categoryRowId)
                
                //Segments
                for index in 0..<category.segments.count {
                    let segment = category.segments[index]
                    
                    segment.categoryId = Int(categoryRowId)
                    let segmentRowId = self.segmentDao.insert(segment)
                    segment.id = Int(segmentRowId)
                }
                
                // Add whole subCategories recursively
                self.insertSubCategory(category: category, categoryRowId: categoryRowId, languageRowId: languageRowId)
            }
        }
    }
    
    /// Insert all the forms
    fileprivate func insertAllForms() {
        //Form
        for form in self.forms {
            let formRowId = self.formDao.insert(form)
            
            // Screen
            for index in 0..<form.screens.count {
                let screen = form.screens[index]
                
                screen.formId = Int(formRowId)
                let screenRowId = self.screenDao.insert(screen)
                screen.id = Int(screenRowId)
                
                // ItemForm
                for index in 0..<screen.items.count {
                    let itemForm = screen.items[index]
                    
                    itemForm.screenId = Int(screenRowId)
                    let itemFormRowId = self.itemFormDao.insert(itemForm)
                    itemForm.id = Int(itemFormRowId)
                    
                    // OptionItem
                    for index in 0..<itemForm.options.count {
                        let optionItem = itemForm.options[index]
                        
                        optionItem.itemFormId = Int(itemFormRowId)
                        let optionItemRowId = self.optionItemDao.insert(optionItem)
                        optionItem.id = Int(optionItemRowId)
                    }
                }
            }
        }
    }
    
    /// Insert all the categories recursively
    ///
    /// - Parameters:
    ///   - category: category parent
    ///   - categoryRowId: rowId of category parent inserted
    ///   - languageRowId: rowId of language inserted
    func insertSubCategory(category: Category, categoryRowId: Int64, languageRowId: Int64) {
        
        // SubCategories
        for index in 0..<category.categories.count {
            let subCategory = category.categories[index]
            subCategory.parent = Int(categoryRowId)
            subCategory.languageId = Int(languageRowId)
            let subCategoryRowId = self.categoryDao.insert(subCategory)
            
            //Segments
            for index in 0..<subCategory.segments.count {
                let segment = subCategory.segments[index]
                
                segment.categoryId = Int(subCategoryRowId)
                let segmentRowId = self.segmentDao.insert(segment)
                segment.id = Int(segmentRowId)
            }
            
            //Checklist
            for index in 0..<subCategory.checkList.count {
                let checkList = subCategory.checkList[index]
                
                checkList.categoryId = Int(subCategoryRowId)
                let checkListRowId = self.checkListDao.insert(checkList)
                checkList.id = Int(checkListRowId)
                
                //CheckItem
                for index in 0..<checkList.items.count {
                    let checkItem = checkList.items[index]
                    
                    checkItem.categoryId = Int(subCategoryRowId)
                    let checkListRowId = self.checkItemDao.insert(checkItem)
                    checkItem.id = Int(checkListRowId)
                }
            }
            
            insertSubCategory(category: subCategory, categoryRowId: categoryRowId, languageRowId: languageRowId)
        }
    }
}
