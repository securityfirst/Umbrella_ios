//
//  MatrixConverterViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 04/09/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class MatrixConverterViewModel {
    
    //
    // MARK: - Properties
    var sqlManager: SQLManager
    lazy var formAnswerDao: FormAnswerDao = {
        let formAnswerDao = FormAnswerDao(sqlProtocol: self.sqlManager)
        return formAnswerDao
    }()
    
    lazy var checklistCheckedDao: ChecklistCheckedDao = {
        let checklistCheckedDao = ChecklistCheckedDao(sqlProtocol: self.sqlManager)
        return checklistCheckedDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    //
    // MARK: - Functions
    
    func listFormAnswer(byFormId formId: Int) -> [FormAnswer] {
        return formAnswerDao.listFormId(at: formId)
    }
    
    //
    // MARK: - Functions
    func lastFormAnswerId() -> Int {
        return Int(formAnswerDao.lastFormAnswerId())
    }
    
    /// Save a formAnswer on database
    ///
    /// - Parameter formAnswer: FormAnswer
    /// - Returns: RowId Int
    func insertFormAnswer(formAnswer: FormAnswer) -> Int64 {
        return formAnswerDao.insert(formAnswer)
    }
    
    /// Remove the formAnswer
    ///
    /// - Parameter formAnswer: FormAnswer
    /// - Returns: Bool
    func removeFormAnswer(formAnswer: FormAnswer) -> Bool {
        return formAnswerDao.remove(formAnswer)
    }
    
    /// Insert a new ChecklistChecked into the database
    ///
    /// - Parameter checklistChecked: ChecklistChecked
    func insertChecklistChecked(_ checklistChecked: ChecklistChecked) {
        _ = self.checklistCheckedDao.insert(checklistChecked)
    }
    
    /// Insert a new ChecklistChecked into the database
    ///
    /// - Parameter checklistChecked: ChecklistChecked
    func listOfChecklistChecked(byChecklistId checklistId: Int) -> [ChecklistChecked] {
        return self.checklistCheckedDao.list(checklistId: checklistId)
    }
}
