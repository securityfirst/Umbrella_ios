//
//  OptionItemDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class OptionItemDaoSpec: QuickSpec {
    
    override func spec() {
        describe("OptionItemDao") {
            
            let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
                
                let dao = LanguageDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let language = Language(name: "en")
                language.id = 1
                _ = dao.insert(language)
            }
            
            it("should create the table of OptionItem in Database") {
                
                let dao = OptionItemDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a ItemForm in Database") {
                
                let formDao = FormDao(sqlProtocol: sqlManager)
                _ = formDao.createTable()
                
                let screen = Screen(name: "Screen1", items: [])
                let form = Form(screens: [screen])
                form.languageId = 1
                let rowId = formDao.insert(form)
                
                let screenDao = ScreenDao(sqlProtocol: sqlManager)
                _ = screenDao.createTable()
                
                screen.formId = Int(rowId)
                let sRowId = screenDao.insert(screen)
                
                let itemFormDao = ItemFormDao(sqlProtocol: sqlManager)
                _ = itemFormDao.createTable()
                
                let itemForm = ItemForm(name: "ItemForm1", type: "type1", label: "label1", hint: "hint1", options: [])
                itemForm.screenId = Int(sRowId)
                let iRow = itemFormDao.insert(itemForm)
                
                let optionItemDao = OptionItemDao(sqlProtocol: sqlManager)
                _ = optionItemDao.createTable()
                
                let optionItem = OptionItem(label: "label1", value: "value1")
                optionItem.itemFormId = Int(iRow)
                let oRowId = optionItemDao.insert(optionItem)
                
                expect(oRowId).to(equal(1))
            }
            
            it("should do to select in table of ItemForm in Database") {
                
                let formDao = FormDao(sqlProtocol: sqlManager)
                _ = formDao.createTable()
                
                let screen = Screen(name: "Screen1", items: [])
                
                let form = Form(screens: [screen])
                form.languageId = 1
                let rowId = formDao.insert(form)
                
                let screenDao = ScreenDao(sqlProtocol: sqlManager)
                _ = screenDao.createTable()
                
                screen.formId = Int(rowId)
                let sRowId = screenDao.insert(screen)
                
                let itemFormDao = ItemFormDao(sqlProtocol: sqlManager)
                _ = itemFormDao.createTable()
                
                let itemForm = ItemForm(name: "ItemForm1", type: "type1", label: "label1", hint: "hint1", options: [])
                itemForm.screenId = Int(sRowId)
                let iRow = itemFormDao.insert(itemForm)
                
                let optionItemDao = OptionItemDao(sqlProtocol: sqlManager)
                _ = optionItemDao.createTable()
                
                let optionItem = OptionItem(label: "label1", value: "value1")
                optionItem.itemFormId = Int(iRow)
                _ = optionItemDao.insert(optionItem)
                
                let list = optionItemDao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of OptionItem in Database") {
                
                let dao = OptionItemDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
