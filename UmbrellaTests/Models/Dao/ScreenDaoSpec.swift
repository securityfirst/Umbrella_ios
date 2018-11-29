//
//  ScreenDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class ScreenDaoSpec: QuickSpec {
    
    override func spec() {
        describe("ScreenDao") {
            
            let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
                
                let dao = LanguageDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let language = Language(name: "en")
                language.id = 1
                _ = dao.insert(language)
            }
            
            it("should create the table of Screen in Database") {
                
                let dao = ScreenDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a Screen in Database") {
                
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
                
                expect(sRowId).to(equal(1))
            }
            
            it("should do to select in table of Screen in Database") {
                
                let formDao = FormDao(sqlProtocol: sqlManager)
                _ = formDao.createTable()
                
                let screen = Screen(name: "Screen1", items: [])
                
                let form = Form(screens: [screen])
                form.languageId = 1
                let rowId = formDao.insert(form)
                
                let screenDao = ScreenDao(sqlProtocol: sqlManager)
                _ = screenDao.createTable()
                
                screen.formId = Int(rowId)
                _ = screenDao.insert(screen)
                
                let list = formDao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of Screen in Database") {
                
                let dao = ScreenDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
