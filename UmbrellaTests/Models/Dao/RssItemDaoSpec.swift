//
//  RssItemDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 01/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class RssItemDaoSpec: QuickSpec {
    
    override func spec() {
        describe("RssItemDao") {
            
            let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
            }
            
            it("should create the table of RssItem in Database") {
                
                let dao = RssItemDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a RssItem in Database") {
                
                let dao = RssItemDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                
                let object = RssItem(url: "http://securityfirst.org")
                let rowId = dao.insert(object)
                
                expect(rowId).to(equal(1))
            }
            
            it("should do to select in table of RssItem in Database") {
                
                let dao = RssItemDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                
                let object = RssItem(url: "http://securityfirst.org")
                _ = dao.insert(object)
                
                let list = dao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of RssItem in Database") {
                
                let dao = RssItemDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
