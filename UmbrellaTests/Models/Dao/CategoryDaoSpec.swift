//
//  CategoryDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CategoryDaoSpec: QuickSpec {
    
    override func spec() {
        describe("CategoryDao") {
            
            let sqlManager = SQLManager(databaseName: "database.db", password: "umbrella")
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
            }
            
            it("should create the table of Category in Database") {
                
                let dao = CategoryDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a Category in Database") {
                
                let languageDao = LanguageDao(sqlProtocol: sqlManager)
                _ = languageDao.createTable()
                
                let language = Language(name: "en")
                let lRowId = languageDao.insert(language)
                
                let dao = CategoryDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let category = Category(name: "Category1", index: 1.0)
                category.languageId = Int(lRowId)
                let rowId = dao.insert(category)
                
                expect(rowId).to(equal(1))
            }
            
            it("should do to select in table of Category in Database") {
                
                let languageDao = LanguageDao(sqlProtocol: sqlManager)
                _ = languageDao.createTable()
                
                let language = Language(name: "en")
                let lRowId = languageDao.insert(language)
                
                let dao = CategoryDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let category = Category(name: "Category1", index: 1.0)
                category.languageId = Int(lRowId)
                _ = dao.insert(category)
                
                let list = dao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of Category in Database") {
                
                let dao = CategoryDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
