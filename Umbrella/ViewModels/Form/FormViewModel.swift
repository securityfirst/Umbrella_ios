//
//  FormViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class FormViewModel {
    
    //
    // MARK: - Properties
    var umbrella: Umbrella
    var sqlManager: SQLManager
    lazy var formAnswerDao: FormAnswerDao = {
        let formAnswerDao = FormAnswerDao(sqlProtocol: self.sqlManager)
        return formAnswerDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.umbrella = Umbrella()
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    //
    // MARK: - Functions
    
    /// Load all forms active
    func loadFormActive() {
        _ = formAnswerDao.createTable()
        self.umbrella.formAnswers = formAnswerDao.listFormActive()
    }
    
    /// Load the formAnswers
    ///
    /// - Parameters:
    ///   - formAnswerId: Int
    ///   - formId: Int
    /// - Returns: Array of FormAnswer
    func loadFormAnswersTo(formAnswerId: Int, formId: Int) -> [FormAnswer] {
        return formAnswerDao.listFormAnswers(at: Int64(formAnswerId), formId: Int64(formId))
    }
    
    /// Remove all formAnswers to formAnswerId
    ///
    /// - Parameter formAnswerId: Int
    func remove(formAnswerId: Int) {
        _ = self.formAnswerDao.remove(formAnswerId)
    }
}
