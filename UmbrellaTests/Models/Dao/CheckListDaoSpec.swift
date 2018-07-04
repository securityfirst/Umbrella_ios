//
//  CheckListDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CheckListDaoSpec: QuickSpec {
    
    override func spec() {
        describe("CheckListDao") {
            
            let sqlManager = SQLManager(databaseName: "database.db", password: "umbrella")
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
            }
            
            it("should create the table of CheckList in Database") {
                
                let dao = CheckListDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a CheckList in Database") {
                
                let languageDao = LanguageDao(sqlProtocol: sqlManager)
                _ = languageDao.createTable()
                
                let language = Language(name: "en")
                let lRowId = languageDao.insert(language)
                
                let dao = CategoryDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let category = Category(name: "Category1", index: 1.0)
                category.languageId = Int(lRowId)
                let rowId = dao.insert(category)
                
                let checkListDao = CheckListDao(sqlProtocol: sqlManager)
                _ = checkListDao.createTable()
                
                let checkList = CheckList(index: 1.0, items: [])
                checkList.categoryId = Int(rowId)
                let sRowId = checkListDao.insert(checkList)
                
                expect(sRowId).to(equal(1))
            }
            
            it("should do to select in table of CheckList in Database") {
                
                let languageDao = LanguageDao(sqlProtocol: sqlManager)
                _ = languageDao.createTable()
                
                let language = Language(name: "en")
                let lRowId = languageDao.insert(language)
                
                let dao = CategoryDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let category = Category(name: "Category1", index: 1.0)
                category.languageId = Int(lRowId)
                let rowId = dao.insert(category)
                
                let checkListDao = CheckListDao(sqlProtocol: sqlManager)
                _ = checkListDao.createTable()
                
                let checkList = CheckList(index: 1.0, items: [])
                checkList.categoryId = Int(rowId)
                _ = checkListDao.insert(checkList)
                
                let list = checkListDao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of CheckList in Database") {
                
                let dao = CheckListDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
