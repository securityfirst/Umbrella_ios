//
//  FormAnswerDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 31/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct FormAnswerDao: DaoProtocol {
    
    //
    // MARK: - Properties
    let sqlProtocol: SQLProtocol
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameter sqlProtocol: SQLProtocol
    init(sqlProtocol: SQLProtocol) {
        self.sqlProtocol = sqlProtocol
    }
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return self.sqlProtocol.create(table: FormAnswer())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [FormAnswer] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(FormAnswer.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: OptionItem.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: FormAnswer) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(FormAnswer.table) ('form_answer_id', 'text', 'choice', 'form_id', 'item_form_id', 'option_item_id') VALUES (\(object.formAnswerId), \"\(object.text)\", \(object.choice), \(object.formId), \(object.itemFormId), \(object.optionItemId))")
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// List of object
    ///
    /// - Parameter formAnswerId: Id to formAnswerId
    /// - Returns: a list of object
    func list(formAnswerId: Int) -> [FormAnswer] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(FormAnswer.table) WHERE form_answer_id = \(formAnswerId)")
    }

    /// List of object to screen Form Active
    ///
    /// - Returns: a list of object
    func listFormActive() -> [FormAnswer] {
        return self.sqlProtocol.select(withQuery: "SELECT form_id, form_answer_id, created_at FROM \(FormAnswer.table) group by form_answer_id")
    }
}
