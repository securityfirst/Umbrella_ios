//
//  LanguageDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class LanguageDaoSpec: QuickSpec {
    
    override func spec() {
        describe("LanguageDao") {
            
            let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
            }
            
            it("should create the table of Language in Database") {
                
                let dao = LanguageDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a Language in Database") {
                
                let languageDao = LanguageDao(sqlProtocol: sqlManager)
                _ = languageDao.createTable()
                
                let language = Language(name: "en")
                let rowId = languageDao.insert(language)
                
                expect(rowId).to(equal(1))
            }
            
            it("should do to select in table of Language in Database") {
                
                let languageDao = LanguageDao(sqlProtocol: sqlManager)
                _ = languageDao.createTable()
                
                let language = Language(name: "en")
                _ = languageDao.insert(language)
                
                let list = languageDao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of Language in Database") {
                
                let dao = LanguageDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
