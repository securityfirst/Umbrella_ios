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
    let sqlProtocol: SQLProtocol
    let languageDao: LanguageDao
    let categoryDao: CategoryDao
    let segmentDao: SegmentDao
    let checkListDao: CheckListDao
    let checkItemDao: CheckItemDao
    let formDao: FormDao
    let screenDao: ScreenDao
    let itemFormDao: ItemFormDao
    let optionItemDao: OptionItemDao
    var languages: [Language]
    var forms: [Form]
    
    //
    // MARK: - Initializers
    
    init(sqlProtocol: SQLProtocol) {
        self.init(languages: [], forms: [], sqlProtocol: sqlProtocol)
    }
    
    init(languages: [Language], forms: [Form], sqlProtocol: SQLProtocol) {
        self.languages = languages
        self.forms = forms
        self.sqlProtocol = sqlProtocol
        
        self.languageDao = LanguageDao(sqlProtocol: self.sqlProtocol)
        self.categoryDao = CategoryDao(sqlProtocol: self.sqlProtocol)
        self.segmentDao = SegmentDao(sqlProtocol: self.sqlProtocol)
        self.checkListDao = CheckListDao(sqlProtocol: self.sqlProtocol)
        self.checkItemDao = CheckItemDao(sqlProtocol: self.sqlProtocol)
        self.formDao = FormDao(sqlProtocol: self.sqlProtocol)
        self.screenDao = ScreenDao(sqlProtocol: self.sqlProtocol)
        self.itemFormDao = ItemFormDao(sqlProtocol: self.sqlProtocol)
        self.optionItemDao = OptionItemDao(sqlProtocol: self.sqlProtocol)
    }
    
    //
    // MARK: - Functions
    
    /// Create all tables
    func createTables() -> Bool {
        let languageSuccess = self.languageDao.createTable()
        let categorySuccess = self.categoryDao.createTable()
        let segmentSuccess = self.segmentDao.createTable()
        let checkListSuccess = self.checkListDao.createTable()
        let checkItemSuccess = self.checkItemDao.createTable()
        
        let formSuccess = self.formDao.createTable()
        let screenSuccess = self.screenDao.createTable()
        let itemFormSuccess = self.itemFormDao.createTable()
        let optionItemSuccess = self.optionItemDao.createTable()
        
        if languageSuccess && categorySuccess && segmentSuccess && checkListSuccess && checkItemSuccess && formSuccess && screenSuccess && itemFormSuccess && optionItemSuccess {
            return true
        } else {
            return false
        }
    }
    
    func dropTables() -> Bool {
        let optionItemSuccess = self.optionItemDao.dropTable()
        let itemFormSuccess = self.itemFormDao.dropTable()
        let screenSuccess = self.screenDao.dropTable()
        let formSuccess = self.formDao.dropTable()
        
        let checkItemSuccess = self.checkItemDao.dropTable()
        let checkListSuccess = self.checkListDao.dropTable()
        let segmentSuccess = self.segmentDao.dropTable()
        let categorySuccess = self.categoryDao.dropTable()
        let languageSuccess = self.languageDao.dropTable()
        
        if languageSuccess && categorySuccess && segmentSuccess && checkListSuccess && checkItemSuccess && formSuccess && screenSuccess && itemFormSuccess && optionItemSuccess {
            return true
        } else {
            return false
        }
    }
    
    /// Convert from object to database
    func objectToDatabase(completion: @escaping (Float) -> Void) {
        DispatchQueue.global(qos: .default).async {
            _ = self.dropTables()
            _ = self.createTables()
            self.insertAllLanguages(completion: completion)
            self.insertAllForms()
            print("Finalized objectToDatabase")
        }
    }
    
    /// Convert from database to object
    mutating func databaseToObject() {
        let languageArray = self.languageDao.list()
        let categoryArray = self.categoryDao.list()
        let segmentArray = self.segmentDao.list()
        let checkListArray = self.checkListDao.list()
        let checkItemArray = self.checkItemDao.list()
        let formArray = self.formDao.list()
        let screenArray = self.screenDao.list()
        let itemformArray = self.itemFormDao.list()
        let optionItemArray = self.optionItemDao.list()
        
        // Languages
        for language in languageArray {
            
            language.categories = categoryArray.filter { $0.languageId == language.id && $0.parent == 0 }
            
            //Categories
            for category in language.categories {
                category.categories = categoryArray.filter { $0.languageId == language.id && $0.parent == category.id }
                
                //Segments
                category.segments = segmentArray.filter { $0.categoryId == category.id }
                
                //Recursively
                convertToObject(category, categoryArray, language, segmentArray, checkListArray, checkItemArray)
            }
            
            self.languages.append(language)
        }
        
        //Forms
        
        // Screen
        for form in formArray {
            form.screens = screenArray.filter { $0.formId == form.id }
            
            //ItemForm
            for screen in form.screens {
                screen.items = itemformArray.filter { $0.screenId == screen.id }
                
                // OptionItem
                for itemForm in screen.items {
                    itemForm.options = optionItemArray.filter { $0.itemFormId == itemForm.id }
                }
            }
            
            self.forms.append(form)
        }
        print("Finalized databaseToObject")
    }
    
    func checkIfTheDatabaseExists() -> Bool {
        return self.sqlProtocol.checkIfTheDatabaseExists()
    }
}

extension UmbrellaDatabase {
    
    /// Insert all the languages, categories, segments and checkList
    fileprivate func insertAllLanguages(completion: @escaping (Float) -> Void) {
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
                self.insertIntoDatabase(category: category, categoryRowId: categoryRowId, languageRowId: languageRowId)
                
                completion(Float(index+1)/Float(language.categories.count))
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
    
    /// Insert categories from object to database recursively
    ///
    /// - Parameters:
    ///   - category: category parent
    ///   - categoryRowId: rowId of category parent inserted
    ///   - languageRowId: rowId of language inserted
    func insertIntoDatabase(category: Category, categoryRowId: Int64, languageRowId: Int64) {
        
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

                    checkItem.checkListId = Int(checkList.id)
                    let checkListRowId = self.checkItemDao.insert(checkItem)
                    checkItem.id = Int(checkListRowId)
                }
            }
            
            insertIntoDatabase(category: subCategory, categoryRowId: subCategoryRowId, languageRowId: languageRowId)
        }
    }
    
    /// Convert categories from database to object recursively
    ///
    /// - Parameters:
    ///   - category: category
    ///   - categories: list of category
    ///   - language: language
    ///   - segments: list of segment
    ///   - checkLists: list of checkList
    ///   - checkItems: list of checkItem
    fileprivate func convertToObject(_ category: Category, _ categories: [Category], _ language: Language, _ segments: [Segment], _ checkLists: [CheckList], _ checkItems: [CheckItem]) {
        
        // Subcategories
        for subcategory in category.categories {
            subcategory.categories = categories.filter { $0.languageId == language.id && $0.parent == subcategory.id }
            
            //Segments2
            subcategory.segments = segments.filter { $0.categoryId == subcategory.id }
            
            //CheckList
            subcategory.checkList = checkLists.filter { $0.categoryId == subcategory.id }
            
            for checkList in subcategory.checkList {
                checkList.items = checkItems.filter { $0.checkListId == checkList.id }
            }
            
            convertToObject(subcategory, categories, language, segments, checkLists, checkItems)
        }
    }
}
