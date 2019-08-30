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
        return self.sqlProtocol.drop(tableName: FormAnswer.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: FormAnswer) -> Int64 {
        
        var sql = ""
        if object.id == -1 {
            sql = "INSERT OR REPLACE INTO \(FormAnswer.table) ('form_answer_id', 'text', 'choice', 'form_id', 'item_form_id', 'option_item_id', 'created_at', 'matrix_url_id') VALUES (\(object.formAnswerId), \"\(object.text)\", \(object.choice), \(object.formId), \(object.itemFormId), \(object.optionItemId), \"\(object.createdAt)\", \"\(object.matrixUrlId)\")"
        } else {
            sql = "INSERT OR REPLACE INTO \(FormAnswer.table) ('id','form_answer_id', 'text', 'choice', 'form_id', 'item_form_id', 'option_item_id', 'created_at', 'matrix_url_id') VALUES (\(object.id), \(object.formAnswerId), \"\(object.text)\", \(object.choice), \(object.formId), \(object.itemFormId), \(object.optionItemId), \"\(object.createdAt)\", \"\(object.matrixUrlId)\")"
        }
        
        let rowId = self.sqlProtocol.insert(withQuery: sql)
        return rowId
    }
    
    //
    // MARK: - Custom functions
    
    /// Delete a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func remove(_ object: FormAnswer) -> Bool {
        let sql = "DELETE FROM \(FormAnswer.table) WHERE form_answer_id = \(object.formAnswerId) AND form_id = \(object.formId) AND item_form_id = \(object.itemFormId) AND option_item_id = \(object.optionItemId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
    /// Delete all formAnswer to formAnswerId in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func remove(_ formAnswerId: Int) -> Bool {
        let sql = "DELETE FROM \(FormAnswer.table) WHERE form_answer_id = \(formAnswerId)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
    
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
    
    /// List of object to screen Form Active
    ///
    /// - Returns: a list of object
    func listFormAnswers(at id:Int64, formId: Int64) -> [FormAnswer] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(FormAnswer.table) WHERE form_answer_id = \(id) and form_id = \(formId)")
    }
    
    /// Get the last number of the formAnswer
    ///
    /// - Returns: Int
    func lastFormAnswerId() -> Int64 {
        let result = self.sqlProtocol.select(withQuery: "SELECT form_answer_id FROM \(FormAnswer.table) ORDER BY form_answer_id DESC LIMIT 1")
        
        if result.count > 0 {
            return (result.first!["form_answer_id"] as? Int64)!
        }
        return 0
    }
}
