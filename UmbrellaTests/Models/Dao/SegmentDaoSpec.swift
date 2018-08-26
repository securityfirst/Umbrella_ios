//
//  SegmentDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class SegmentDaoSpec: QuickSpec {
    
    override func spec() {
        describe("SegmentDao") {
            
            let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
            }
            
            it("should create the table of Segment in Database") {
                
                let dao = SegmentDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                
                expect(success).to(beTrue())
            }
            
            it("should insert a Segment in Database") {
                
                let languageDao = LanguageDao(sqlProtocol: sqlManager)
                _ = languageDao.createTable()
                
                let language = Language(name: "en")
                let lRowId = languageDao.insert(language)
                
                let dao = CategoryDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let category = Category(name: "Category1", index: 1.0)
                category.languageId = Int(lRowId)
                let rowId = dao.insert(category)
                
                let segmentDao = SegmentDao(sqlProtocol: sqlManager)
                _ = segmentDao.createTable()
                
                let segment = Segment(name: "Segment1", index: 1.0, content: "## Hello")
                segment.categoryId = Int(rowId)
                let sRowId = segmentDao.insert(segment)
                
                expect(sRowId).to(equal(1))
            }
            
            it("should do to select in table of Segment in Database") {
                
                let languageDao = LanguageDao(sqlProtocol: sqlManager)
                _ = languageDao.createTable()
                
                let language = Language(name: "en")
                let lRowId = languageDao.insert(language)
                
                let dao = CategoryDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let category = Category(name: "Category1", index: 1.0)
                category.languageId = Int(lRowId)
                let rowId = dao.insert(category)
                
                let segmentDao = SegmentDao(sqlProtocol: sqlManager)
                _ = segmentDao.createTable()
                
                let segment = Segment(name: "Segment1", index: 1.0, content: "## Hello")
                segment.categoryId = Int(rowId)
                _ = segmentDao.insert(segment)
                
                let list = segmentDao.list()
                
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of Segment in Database") {
                
                let dao = SegmentDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
