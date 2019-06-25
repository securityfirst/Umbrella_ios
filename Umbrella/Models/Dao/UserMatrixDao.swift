//
//  UserMatrixDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct UserMatrixDao: DaoProtocol {
    
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
    
    //
    // MARK: - DaoProtocol
    
    /// Create the table
    ///
    /// - Returns: boolean if it was created
    func createTable() -> Bool {
        return self.sqlProtocol.create(table: UserMatrix())
    }
    
    /// List of object
    ///
    /// - Returns: a list of object
    func list() -> [UserMatrix] {
        return self.sqlProtocol.select(withQuery: "SELECT * FROM \(UserMatrix.table)")
    }
    
    /// Drop the table
    ///
    /// - Returns: boolean if it was dropped
    func dropTable() -> Bool {
        return self.sqlProtocol.drop(tableName: UserMatrix.table)
    }
    
    /// Insert a object in database
    ///
    /// - Parameter object: object
    /// - Returns: rowId of object inserted
    func insert(_ object: UserMatrix) -> Int64 {
        let rowId = self.sqlProtocol.insert(withQuery: "INSERT INTO \(UserMatrix.table) ('username', 'password', 'user_id', 'access_token', 'home_server', 'device_id') VALUES (\"\(object.username)\", \"\(object.password)\", \"\(object.userId)\", \"\(object.accessToken)\", \"\(object.homeServer)\", \"\(object.deviceId)\")")
        return rowId
    }
    
    /// Reset connection
    ///
    func resetConnection() {
        self.sqlProtocol.resetConnection()
    }
    
    //
    // MARK: - Custom functions
    
    /// Delete all
    ///
    /// - Returns: rowId of object inserted
    func removeAll() -> Bool {
        let sql = "DELETE FROM \(UserMatrix.table)"
        return self.sqlProtocol.remove(withQuery: sql)
    }
}
