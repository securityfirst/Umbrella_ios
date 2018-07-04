//
//  FormDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FormDaoSpec: QuickSpec {
    
    override func spec() {
        describe("FormDao") {
            
            let sqlManager = SQLManager(databaseName: "database.db", password: "umbrella")
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
            }
            
            it("should create the table of Form in Database") {
                
                let dao = FormDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a Form in Database") {
                
                let formDao = FormDao(sqlProtocol: sqlManager)
                _ = formDao.createTable()
                
                let screen = Screen(name: "Screen1", items: [])
                
                let form = Form(screens: [screen])
                let rowId = formDao.insert(form)
                
                expect(rowId).to(equal(1))
            }
            
            it("should do to select in table of Form in Database") {
                
                let formDao = FormDao(sqlProtocol: sqlManager)
                _ = formDao.createTable()
                
                let screen = Screen(name: "Screen1", items: [])
                
                let form = Form(screens: [screen])
                _ = formDao.insert(form)
                
                let list = formDao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of Form in Database") {
                
                let dao = FormDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
