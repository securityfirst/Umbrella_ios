//
//  DifficultyViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class DifficultyViewModel {
    
    //
    // MARK: - Properties
    var categoryParent: Category?
    var difficulties: [Category] = [Category]()
    
    var sqlManager: SQLManager
    lazy var difficultyRuleDao: DifficultyRuleDao = {
        let difficultyRuleDao = DifficultyRuleDao(sqlProtocol: self.sqlManager)
        return difficultyRuleDao
    }()
    
    //
    // MARK: - Init
    init() {
        categoryParent = nil
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    //
    // MARK: - Functions
    
    /// Insert a new DifficultyRule into the database
    ///
    /// - Parameter difficultyRule: DifficultyRule
    func insert(_ difficultyRule: DifficultyRule) {
        _ = self.difficultyRuleDao.insert(difficultyRule)
    }
}
