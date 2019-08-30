//
//  SQLManager.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite
import SQLCipher

class SQLManager: SQLProtocol {
    
    //
    // MARK: - Properties
    let fileManager: FileManager
    let databaseName: String
    var password: String
    var connect: Connection?
    static let timeout = 60.0
    
    //
    // MARK: - Initializers
    
    /// Init
    ///
    /// - Parameters:
    ///   - fileManager: FileManager
    ///   - databaseName: database name
    ///   - password: password of database
    init(fileManager: FileManager = FileManager.default, databaseName: String, password: String) {
        self.fileManager = fileManager
        self.databaseName = databaseName
        self.password = password
        self.copyDatabaseIfNeeded()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SQLManager.resetAllConnections(notification:)), name: Notification.Name("ResetRepository"), object: nil)
    }
    
    //
    // MARK: - Functions
    
    /// Select in SQLite database
    ///
    /// - Parameter query: string of query
    /// - Returns: return list of object
    func select<T: Decodable>(withQuery query:String) -> [T] {
        
        let db = openConnection()
        
        if db == nil {
            return []
        }
        
        var array = [[String: Any]]()
        
        do {
            if let stmt = try db?.prepare(query) {
                for row in stmt {
                    var dictionary = [String:Any]()
                    
                    for (index, name) in stmt.columnNames.enumerated() {
                        let value = row[index] ?? ""
                        dictionary.updateValue(value, forKey: name)
                    }
                    array.append(dictionary)
                }
                
                guard let data = try? JSONSerialization.data(withJSONObject: array, options: []) else {
                    return []
                }
                
                let encoded = try JSONDecoder().decode([T].self, from: data)
                return encoded
            }
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Select in SQLite database
    ///
    /// - Parameter query: string of query
    /// - Returns: return list of object
    func select(withQuery query:String) -> [[String: Any]] {
        
        let db = openConnection()
        
        if db == nil {
            return []
        }
        
        var array = [[String: Any]]()
        
        do {
            if let stmt = try db?.prepare(query) {
                for row in stmt {
                    var dictionary = [String:Any]()
                    
                    for (index, name) in stmt.columnNames.enumerated() {
                        dictionary.updateValue(row[index]!, forKey: name)
                    }
                    array.append(dictionary)
                }
                return array
            }
        } catch {
            print(error)
        }
        
        return []
    }
    
    /// Create a table on SQLite
    ///
    /// - Parameter tableProtocol: object that implement the tableProtocol
    /// - Returns: boolean if it was created a table
    func create(table tableProtocol: TableProtocol) -> Bool {
        resetConnection()
        
        let db = openConnection()
        
        if db == nil {
            return false
        }
        
        db?.busyTimeout = SQLManager.timeout
        do {
            let table = Table(tableProtocol.tableName)
            
            let tableSQL = table.create(ifNotExists: true) { tableColumn in
                
                for column in tableProtocol.columns() {
                    
                    switch (column.type) {
                    case .int?:
                        if (column.isNotNull) {
                            tableColumn.column(Expression<Int64>(column.name!))
                        } else {
                            tableColumn.column(Expression<Int64?>(column.name!))
                        }
                    case .real?:
                        if (column.isNotNull) {
                            tableColumn.column(Expression<Float64>(column.name!))
                        } else {
                            tableColumn.column(Expression<Float64?>(column.name!))
                        }
                    case .string?:
                        if (column.isNotNull) {
                            tableColumn.column(Expression<String>(column.name!))
                        } else {
                            tableColumn.column(Expression<String?>(column.name!))
                        }
                    case .primaryKey?:
                        let exp = Expression<Int64>(column.name!)
                        tableColumn.column(exp, primaryKey: .autoincrement)
                    case .primaryStringKey?:
                        let exp = Expression<String>(column.name!)
                        tableColumn.column(exp, primaryKey: true)
                    case .foreignKey?:
                        let foreignKey = Expression<Int64>((column.foreignKey?.key)!)
                        tableColumn.column(foreignKey)
                        let key = Expression<Int64>((column.foreignKey?.tableKey)!)
                        tableColumn.foreignKey(foreignKey, references: (column.foreignKey?.table)!, key, delete: .setNull)
                    case .foreignStringKey?:
                        let foreignKey = Expression<String>((column.foreignKey?.key)!)
                        tableColumn.column(foreignKey)
                        let key = Expression<String>((column.foreignKey?.tableKey)!)
                        tableColumn.foreignKey(foreignKey, references: (column.foreignKey?.table)!, key, delete: .setNull)
                    default:
                        break
                    }
                }
            }
//            print(tableSQL.asSQL())
            try db?.run(tableSQL)
            
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    /// Remove a row on table
    ///
    /// - Parameter query: string with a query
    /// - Returns: rowId of insertion
    func remove(withQuery query:String) -> Bool {
        let db = openConnection()
        do {
            try db?.prepare(query).run()
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    /// Insert a row on table
    ///
    /// - Parameter query: string with a query
    /// - Returns: rowId of insertion
    func insert(withQuery query:String) -> Int64 {
        let db = openConnection()
        
        if db == nil {
            return -1
        }
        
        do {
            try db?.prepare(query).run()
            return (db?.lastInsertRowid)!
        } catch {
//            print(query)
            print(error)
            return -1
        }
    }
    
    /// Drop a table
    ///
    /// - Parameter table: table name
    /// - Returns: boolean if it was dropped
    func drop(tableName table: String) -> Bool {
        let db = openConnection()
        do {
            let tab = Table(table)
            try db?.run(tab.drop(ifExists: true))
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    /// Check if the database exists
    ///
    /// - Returns: boolean
    func checkIfTheDatabaseExists() -> Bool {
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        guard documentsUrl.count != 0 else {
            return false
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(self.databaseName)
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            return false
        } else {
            return true
        }
    }
    
}

extension SQLManager {
    
    /// Open connection with the database
    ///
    /// - Returns: Connection
    func openConnection() -> Connection? {
        
        self.copyDatabaseIfNeeded()
        
        if let passwordCustom: Bool = UserDefaults.standard.object(forKey: "passwordCustom") as? Bool {
            if passwordCustom {
                self.password = CustomPassword.shared.password
            } else {
                self.password = Database.password
            }
        }
        
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        do {
            if self.connect == nil {
                self.connect = try Connection("\(path)/\(self.databaseName)")
                try self.connect?.execute("PRAGMA foreign_keys = ON;")
                try self.connect?.key(self.password)
                
                self.connect?.busyTimeout = SQLManager.timeout
                self.connect?.busyHandler({ tries in
                    if tries >= 3 {
                        return false
                    }
                    return true
                })
            }
            
            #if DEBUG
            self.connect?.trace { print($0) }
            #endif
            return self.connect
        } catch {
            print(error)
            self.connect = nil
            return nil
        }
    }
    
    /// Reset connection
    func resetConnection() {
        self.connect = nil
    }
    
    /// Reset all connections
    ///
    /// - Parameter notification: NSNotification
    @objc func resetAllConnections(notification: NSNotification) {
        resetConnection()
    }
    
    /// Change password
    ///
    /// - Parameter password: String
    func changePassword(oldPassword: String, newPassword: String) {
        let connect = openConnection()
        do {
            try connect?.key(oldPassword)
            try connect?.rekey(newPassword)
            
            UserDefaults.standard.set(true, forKey: "passwordCustom")
            UserDefaults.standard.synchronize()
            
        } catch {
            print(error)
        }
        
    }
    
    /// Copy the database if needed
    fileprivate func copyDatabaseIfNeeded() {
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        guard documentsUrl.count != 0 else {
            return
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(self.databaseName)
        
        if !((try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent(self.databaseName)
            
            do {    
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
        }
    }
}
