//
//  FormAnswerDaoSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 15/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FormAnswerDaoSpec: QuickSpec {
    
    override func spec() {
        describe("FormAnswerDao") {
            
            let sqlManager = SQLManager(databaseName: "database.db", password: "umbrella")
            
            beforeEach {
                _ = UmbrellaDatabase(sqlProtocol: sqlManager).dropTables()
            }
            it("should create the table of FormAnswer in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                let success = dao.createTable()
                expect(success).to(beTrue())
            }
            
            it("should insert a FormAnswer in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let formAnswer = FormAnswer(formAnswerId: 1, formId: 1, itemFormId: 1, optionItemId: -1, text: "Test text_input", choice: -1)
                let rowId = dao.insert(formAnswer)
                expect(rowId).to(equal(1))
            }
            
            it("should do to select in table of FormAnswer in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let formAnswer = FormAnswer(formAnswerId: 1, formId: 1, itemFormId: 1, optionItemId: -1, text: "Test text_input", choice: -1)
                _ = dao.insert(formAnswer)
                let list = dao.list()
                expect(list.count).to(equal(1))
            }
            
            it("should drop the table of FormAnswer in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                let success = dao.dropTable()
                expect(success).to(beTrue())
            }
            
            it("should remove a FormAnswer in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let formAnswer = FormAnswer(formAnswerId: 1, formId: 1, itemFormId: 1, optionItemId: -1, text: "Test text_input", choice: -1)
                _ = dao.insert(formAnswer)
                let success = dao.remove(formAnswer)
                 expect(success).to(beTrue())
            }
            
            it("should remove a FormAnswer with formAnswerId == 1 in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let formAnswer = FormAnswer(formAnswerId: 1, formId: 1, itemFormId: 1, optionItemId: -1, text: "Test text_input", choice: -1)
                _ = dao.insert(formAnswer)
                let success = dao.remove(1)
                expect(success).to(beTrue())
            }
            
            it("should do to select in table of FormAnswer of a formAnswerId in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let formAnswer = FormAnswer(formAnswerId: 1, formId: 1, itemFormId: 1, optionItemId: -1, text: "Test text_input", choice: -1)
                _ = dao.insert(formAnswer)
                let list = dao.list(formAnswerId: 1)
                expect(list.count).to(equal(1))
            }
            
            it("should do to select in table of FormAnswer to all formActive in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let formAnswer = FormAnswer(formAnswerId: 1, formId: 1, itemFormId: 1, optionItemId: -1, text: "Test text_input", choice: -1)
                _ = dao.insert(formAnswer)
                let list = dao.listFormActive()
                expect(list.count).to(equal(1))
            }
            
            it("should do to select in table of FormAnswer of a formAnswerId and formId in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let formAnswer = FormAnswer(formAnswerId: 1, formId: 1, itemFormId: 1, optionItemId: -1, text: "Test text_input", choice: -1)
                _ = dao.insert(formAnswer)
                let list = dao.listFormAnswers(at: 1, formId: 1)
                expect(list.count).to(equal(1))
            }
            
            it("should do to select in table of FormAnswer and return last row id in Database") {
                
                let dao = FormAnswerDao(sqlProtocol: sqlManager)
                _ = dao.createTable()
                let formAnswer = FormAnswer(formAnswerId: 1, formId: 1, itemFormId: 1, optionItemId: -1, text: "Test text_input", choice: -1)
                _ = dao.insert(formAnswer)
                let rowId = dao.lastFormAnswerId()
                expect(rowId).to(equal(1))
            }
        }
    }
}
