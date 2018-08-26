//
//  DynamicFormViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class DynamicFormViewModel {
    
    //
    // MARK: - Properties
    var screen: Screen
    var formAnswerId: Int64 = -1
    var newFormAnswerId: Int64 = -1
    var formAnswers: [FormAnswer]
    var sqlManager: SQLManager
    lazy var formAnswerDao: FormAnswerDao = {
        let formAnswerDao = FormAnswerDao(sqlProtocol: self.sqlManager)
        return formAnswerDao
    }()
    
    //
    // MARK: - Init
    init() {
        self.screen = Screen()
        self.formAnswers = []
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    //
    // MARK: - Functions
    
    /// Save a formAnswer on database
    ///
    /// - Parameter formAnswer: FormAnswer
    /// - Returns: RowId Int
    func save(formAnswer: FormAnswer) -> Int64 {
        return formAnswerDao.insert(formAnswer)
    }
    
    /// Remove the formAnswer
    ///
    /// - Parameter formAnswer: FormAnswer
    /// - Returns: Bool
    func remove(formAnswer: FormAnswer) -> Bool {
        return formAnswerDao.remove(formAnswer)
    }
}
