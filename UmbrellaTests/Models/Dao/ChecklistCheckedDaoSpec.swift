//
//  ChecklistCheckedDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ChecklistCheckedDaoSpec: QuickSpec {
    
    override func spec() {
        describe("ChecklistCheckedDao") {
            
            let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
                
                let dao = LanguageDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let language = Language(name: "en")
                language.id = 1
                _ = dao.insert(language)
            }
            
            it("should create the table of ChecklistChecked in Database") {
                
                let dao = ChecklistCheckedDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a ChecklistChecked in Database") {
                
                let dao = ChecklistCheckedDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                
                let object = ChecklistChecked(subCategoryName: "SubCategory", subCategoryId: 1, difficultyId: 1, checklistId: 1, itemId: 1, totalChecked: 1, totalItemsChecklist: 1)
                object.languageId = 1
                let rowId = dao.insert(object)
                
                expect(rowId).to(equal(1))
            }
            
            it("should do to select in table of ChecklistChecked in Database") {
                
                let dao = ChecklistCheckedDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                
                let object = ChecklistChecked(subCategoryName: "SubCategory", subCategoryId: 1, difficultyId: 1, checklistId: 1, itemId: 1, totalChecked: 1, totalItemsChecklist: 1)
                object.languageId = 1
                _ = dao.insert(object)
                
                let list = dao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of ChecklistChecked in Database") {
                
                let dao = ChecklistCheckedDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
