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
    let formAnswerDao: FormAnswerDao
    let rssItemDao: RssItemDao
    let difficultyRuleDao: DifficultyRuleDao
    let checklistCheckedDao: ChecklistCheckedDao
    let favouriteLessonDao: FavouriteLessonDao
    
    let customChecklistDao: CustomChecklistDao
    let customCheckItemDao: CustomCheckItemDao
    let customChecklistCheckedDao: CustomChecklistCheckedDao
    
    static var languagesStatic: [Language] = [Language]()
    static var umbrellaStatic: Umbrella = Umbrella()
    static var loadedContent: Bool = false
    
    var languages: [Language]
    var forms: [Form]
    var formAnswers: [FormAnswer]
    
    //
    // MARK: - Initializers
    
    init(sqlProtocol: SQLProtocol) {
        self.init(languages: [], forms: [], sqlProtocol: sqlProtocol)
    }
    
    init(languages: [Language], forms: [Form], sqlProtocol: SQLProtocol) {
        self.languages = languages
        self.forms = forms
        self.sqlProtocol = sqlProtocol
        self.formAnswers = []
        
        self.languageDao = LanguageDao(sqlProtocol: self.sqlProtocol)
        self.categoryDao = CategoryDao(sqlProtocol: self.sqlProtocol)
        self.segmentDao = SegmentDao(sqlProtocol: self.sqlProtocol)
        self.checkListDao = CheckListDao(sqlProtocol: self.sqlProtocol)
        self.checkItemDao = CheckItemDao(sqlProtocol: self.sqlProtocol)
        self.formDao = FormDao(sqlProtocol: self.sqlProtocol)
        self.screenDao = ScreenDao(sqlProtocol: self.sqlProtocol)
        self.itemFormDao = ItemFormDao(sqlProtocol: self.sqlProtocol)
        self.optionItemDao = OptionItemDao(sqlProtocol: self.sqlProtocol)
        self.formAnswerDao = FormAnswerDao(sqlProtocol: self.sqlProtocol)
        self.difficultyRuleDao = DifficultyRuleDao(sqlProtocol: self.sqlProtocol)
        self.rssItemDao = RssItemDao(sqlProtocol: self.sqlProtocol)
        self.checklistCheckedDao = ChecklistCheckedDao(sqlProtocol: self.sqlProtocol)
        self.favouriteLessonDao = FavouriteLessonDao(sqlProtocol: self.sqlProtocol)
        self.customChecklistDao = CustomChecklistDao(sqlProtocol: self.sqlProtocol)
        self.customCheckItemDao = CustomCheckItemDao(sqlProtocol: self.sqlProtocol)
        self.customChecklistCheckedDao = CustomChecklistCheckedDao(sqlProtocol: self.sqlProtocol)
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
        let formAnswerSuccess = self.formAnswerDao.createTable()
        let difficultyRuleSuccess = self.difficultyRuleDao.createTable()
        let rssItemSuccess = self.rssItemDao.createTable()
        let checklistCheckedSuccess = self.checklistCheckedDao.createTable()
        let favouriteSegmentSuccess = self.favouriteLessonDao.createTable()
        let customChecklistSuccess = self.customChecklistDao.createTable()
        let customCheckItemSuccess = self.customCheckItemDao.createTable()
        let customChecklistCheckedSuccess = self.customChecklistCheckedDao.createTable()
        
        if languageSuccess && categorySuccess && segmentSuccess && checkListSuccess && checkItemSuccess && formSuccess && screenSuccess && itemFormSuccess && optionItemSuccess && formAnswerSuccess && difficultyRuleSuccess && rssItemSuccess && checklistCheckedSuccess && favouriteSegmentSuccess && customChecklistSuccess && customCheckItemSuccess && customChecklistCheckedSuccess {
            return true
        } else {
            return false
        }
    }
    
    /// Drop all tables
    ///
    /// - Returns: Bool
    func dropTables() -> Bool {
        let customChecklistCheckedSuccess = self.customChecklistCheckedDao.dropTable()
        let customCheckItemSuccess = self.customCheckItemDao.dropTable()
        let customChecklistSuccess = self.customChecklistDao.dropTable()
        let rssItemSuccess = self.rssItemDao.dropTable()
        let checklistCheckedSuccess = self.checklistCheckedDao.dropTable()
        let favouriteSegmentSuccess = self.favouriteLessonDao.dropTable()
        let difficultyRuleSuccess = self.difficultyRuleDao.dropTable()
        let formAnswerSuccess = self.formAnswerDao.dropTable()
        let optionItemSuccess = self.optionItemDao.dropTable()
        let itemFormSuccess = self.itemFormDao.dropTable()
        let screenSuccess = self.screenDao.dropTable()
        let formSuccess = self.formDao.dropTable()
        let checkItemSuccess = self.checkItemDao.dropTable()
        let checkListSuccess = self.checkListDao.dropTable()
        let segmentSuccess = self.segmentDao.dropTable()
        let categorySuccess = self.categoryDao.dropTable()
        let languageSuccess = self.languageDao.dropTable()
        
        if languageSuccess && categorySuccess && segmentSuccess && checkListSuccess && checkItemSuccess && formSuccess && screenSuccess && itemFormSuccess && optionItemSuccess && formAnswerSuccess && difficultyRuleSuccess && rssItemSuccess && checklistCheckedSuccess && favouriteSegmentSuccess && customChecklistSuccess && customCheckItemSuccess && customChecklistCheckedSuccess {
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
            self.insertAllObjects(completion: completion)
            UmbrellaDatabase.languagesStatic = self.languages
            UmbrellaDatabase.loadedContent = true
            UmbrellaDatabase.umbrellaStatic = Umbrella(languages: self.languages, forms: self.forms, formAnswers: self.formAnswers)
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
            //Sort by Index
            language.categories.sort(by: { $0.index! < $1.index!})
            
            //Categories
            for category in language.categories {
                category.categories = categoryArray.filter { $0.languageId == language.id && $0.parent == category.id }
                //Sort by Index
                category.categories.sort(by: { $0.index! < $1.index!})
                
                //Segments
                category.segments = segmentArray.filter { $0.categoryId == category.id }
                
                //Sort by Index
                category.segments.sort(by: { $0.index! < $1.index!})
                
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
        
        // FormAnswer - Form Active
        self.formAnswers = self.formAnswerDao.listFormActive()
        UmbrellaDatabase.languagesStatic = self.languages
        UmbrellaDatabase.loadedContent = true
        UmbrellaDatabase.umbrellaStatic = Umbrella(languages: self.languages, forms: self.forms, formAnswers: self.formAnswers)
    }
    
    /// Check if the database exists
    ///
    /// - Returns: Bool
    func checkIfTheDatabaseExists() -> Bool {
        return self.sqlProtocol.checkIfTheDatabaseExists()
    }
    
    /// Get all categories of a language
    ///
    /// - Parameter lang: String
    /// - Returns: [Category]
    static func categories(lang: String = Locale.current.languageCode!) -> [Category] {
        
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == lang}.first
        
        if let language = language {
            return language.categories
        }
        
        return [Category]()
    }
}

extension UmbrellaDatabase {
    
    /// Insert all the languages, categories, segments and checkList
    fileprivate func insertAllObjects(completion: @escaping (Float) -> Void) {
        
        let totalCategories = self.languages.reduce(0, { $0 + $1.categories.count })
        var countCategories = 0
        
        // Language
        for language in self.languages {
            
            //Sort by Index
            language.categories.sort(by: { $0.index! < $1.index!})
            
            let languageRowId = self.languageDao.insert(language)
            language.id = Int(languageRowId)
            
            // To this moment we need to add whole category parent separete of subcategories
            // Categories
            for index in 0..<language.categories.count {
                countCategories+=1
                
                let category = language.categories[index]
                category.languageId = Int(languageRowId)
                let categoryRowId = self.categoryDao.insert(category)
                category.id = Int(categoryRowId)
                //Sort by Index
                category.categories.sort(by: { $0.index! < $1.index!})
                
                //Segments
                for index in 0..<category.segments.count {
                    let segment = category.segments[index]
                    
                    segment.categoryId = Int(categoryRowId)
                    let segmentRowId = self.segmentDao.insert(segment)
                    segment.id = Int(segmentRowId)
                }
                
                //Sort by Index
                category.segments.sort(by: { $0.index! < $1.index!})
                
                // Add whole subCategories recursively
                self.insertIntoDatabase(category: category, categoryRowId: categoryRowId, languageRowId: languageRowId)
                let percent = Float(countCategories)/Float(totalCategories)
                completion(percent)
            }
        }
        
        // I must languageId to insert the forms
        self.insertAllForms()
    }
    
    /// Insert all the forms
    fileprivate func insertAllForms() {
        //Form
        for form in self.forms {
            
            let language = self.languages.filter { $0.name == form.language}.first
            
            if let language = language {
                form.languageId = language.id
            }
            
            let formRowId = self.formDao.insert(form)
            form.id = Int(formRowId)
            
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
            subCategory.id = Int(subCategoryRowId)
            
            //Sort by Index
            subCategory.categories.sort(by: { $0.index! < $1.index!})
            
            //Segments
            for index in 0..<subCategory.segments.count {
                let segment = subCategory.segments[index]
                
                segment.categoryId = Int(subCategoryRowId)
                let segmentRowId = self.segmentDao.insert(segment)
                segment.id = Int(segmentRowId)
            }
            
            //Sort by Index
            subCategory.segments.sort(by: { $0.index! < $1.index!})
            
            //Checklist
            for index in 0..<subCategory.checkLists.count {
                let checkList = subCategory.checkLists[index]
                
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
            
            //Sort by Index
            subCategory.checkLists.sort(by: { $0.index! < $1.index!})
            
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
            //Sort by Index
            subcategory.categories.sort(by: { $0.index! < $1.index!})
            
            //Segments
            subcategory.segments = segments.filter { $0.categoryId == subcategory.id }
            
            //Sort by Index
            subcategory.segments.sort(by: { $0.index! < $1.index!})
            
            //CheckList
            subcategory.checkLists = checkLists.filter { $0.categoryId == subcategory.id }
            
            //Sort by Index
            subcategory.checkLists.sort(by: { $0.index! < $1.index!})
            
            for checkList in subcategory.checkLists {
                checkList.items = checkItems.filter { $0.checkListId == checkList.id }
            }
            
            convertToObject(subcategory, categories, language, segments, checkLists, checkItems)
        }
    }
}
