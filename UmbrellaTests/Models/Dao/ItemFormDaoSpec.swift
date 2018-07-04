//
//  ItemFormDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ItemFormDaoSpec: QuickSpec {
    
    override func spec() {
        
        let sqlManager = SQLManager(databaseName: "database.db", password: "umbrella")
        
        beforeEach {
            _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
        }
        
        describe("ItemFormDao") {
            
            it("should create the table of ItemForm in Database") {
                
                let dao = ItemFormDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a ItemForm in Database") {
                
                let formDao = FormDao(sqlProtocol: sqlManager)
                _ = formDao.createTable()
                
                let screen = Screen(name: "Screen1", items: [])
                let form = Form(screens: [screen])
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
                
                expect(iRow).to(equal(1))
            }
            
            it("should do to select in table of ItemForm in Database") {
                
                let formDao = FormDao(sqlProtocol: sqlManager)
                _ = formDao.createTable()
                
                let screen = Screen(name: "Screen1", items: [])
                
                let form = Form(screens: [screen])
                let rowId = formDao.insert(form)
                
                let screenDao = ScreenDao(sqlProtocol: sqlManager)
                _ = screenDao.createTable()
                
                screen.formId = Int(rowId)
                let sRowId = screenDao.insert(screen)
                
                let itemFormDao = ItemFormDao(sqlProtocol: sqlManager)
                _ = itemFormDao.createTable()
                
                let itemForm = ItemForm(name: "ItemForm1", type: "type1", label: "label1", hint: "hint1", options: [])
                itemForm.screenId = Int(sRowId)
                _ = itemFormDao.insert(itemForm)
                
                let list = itemFormDao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of ItemForm in Database") {
                
                let dao = ItemFormDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
