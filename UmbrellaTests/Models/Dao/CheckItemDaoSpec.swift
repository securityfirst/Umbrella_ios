//
//  CheckItemDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class CheckItemDaoSpec: QuickSpec {
    
    override func spec() {
        describe("CheckItemDao") {
            
            let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
            }
            
            it("should create the table of CheckItem in Database") {
                
                let dao = CheckItemDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a CheckItem in Database") {
                
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
                let clRowId = checkListDao.insert(checkList)
                
                let checkItemDao = CheckItemDao(sqlProtocol: sqlManager)
                _ = checkItemDao.createTable()
                
                let checkItem = CheckItem(name: "CheckItem1")
                checkItem.checkListId = Int(clRowId)
                let ciRowId = checkItemDao.insert(checkItem)
                
                expect(ciRowId).to(equal(1))
            }
            
            it("should do to select in table of CheckItem in Database") {
                
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
                let clRowId = checkListDao.insert(checkList)
                
                let checkItemDao = CheckItemDao(sqlProtocol: sqlManager)
                _ = checkItemDao.createTable()
                
                let checkItem = CheckItem(name: "CheckItem1")
                checkItem.checkListId = Int(clRowId)
                _ = checkItemDao.insert(checkItem)
                
                let list = checkListDao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of CheckItem in Database") {
                
                let dao = CheckItemDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
