//
//  UmbrellaDatabaseSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 03/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class UmbrellaDatabaseSpec: QuickSpec {
    
    override func spec() {
        
        let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        var languages = [Language]()
        var forms = [Form]()
        
        beforeEach {
            
            languages = []
            forms = []
            let language = Language(name: "en")
            
            let category = Category(name: "Category1", description: "Description", index: 1.0)
            let segment = Segment(name: "Segment1", index: 1.0, content: "## Hello")
            category.segments.append(segment)
            
            let checkList = CheckList(index: 1.0, items: [CheckItem(name: "CheckItem1")])
            category.checkLists.append(checkList)
            language.categories.append(category)
            
            languages.append(language)
            
            let optionItem = OptionItem(label: "label1", value: "value1")
            let itemForm = ItemForm(name: "ItemForm1", type: "type1", label: "label1", hint: "hint1", options: [optionItem])
            let screen = Screen(name: "Screen1", items: [itemForm])
            let form = Form(screens: [screen])
            forms.append(form)
        }
        describe("UmbrellaDatabase1") {
            it("should create all tables") {
                
                let dao = UmbrellaDatabase(languages: [], forms: [], sqlProtocol: sqlManager)
                let success = dao.createTables()
                expect(success).to(beTrue())
            }
            
            it("should drop all tables") {
                
                let dao = UmbrellaDatabase(languages: [], forms: [], sqlProtocol: sqlManager)
                _ = dao.createTables()
                let success = dao.dropTables()
                expect(success).to(beTrue())
            }
        }
        
        describe("UmbrellaDatabase2") {
            
            it("should convert from object to database and viceversa") {
                
                var dao = UmbrellaDatabase(languages: languages, forms: forms, sqlProtocol: sqlManager)
                _ = dao.dropTables()
                _ = dao.createTables()
                waitUntil(timeout: 600) { done in
                    dao.objectToDatabase(completion: { progress in
                        if progress == 1.0 {
                            expect(progress).to(equal(1.0))
                            languages = []
                            forms = []
                            dao.languages = []
                            dao.forms = []
                            dao.databaseToObject()
                            
                            expect(dao.languages.count).to(equal(1))
                            expect(dao.languages.first?.categories.count).to(equal(1))
                            
                            done()
                        }
                    })
                }
            }
            
            it("should check if the database exists") {
                
                let dao = UmbrellaDatabase(languages: [], forms: [], sqlProtocol: sqlManager)
                let success = dao.checkIfTheDatabaseExists()
                expect(success).to(beTrue())
            }
            
            afterEach {
                
            }
        }
    }
}
