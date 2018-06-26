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

class SQLManager {
    
    //
    // MARK: - Singleton
    static let shared: SQLManager = {
        let sqlmanager = SQLManager()
        sqlmanager.copyDatabaseIfNeeded()
        return sqlmanager
    }()
    
    //
    // MARK: - Functions

    /// Select in SQLite database
    ///
    /// - Parameter query: string of query
    /// - Returns: return list of object
    func select<T: Decodable>(withQuery query:String) -> [T] {
        
        let db = openConnection()
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
    
    /// Create a table on SQLite
    ///
    /// - Parameter tableProtocol: object that implement the tableProtocol
    /// - Returns: boolean if it was created a table
    func create(table tableProtocol: TableProtocol) -> Bool {
        let db = openConnection()
        do {
            let table = Table(tableProtocol.tableName)
            try db?.run(table.create(ifNotExists: true) { tableColumn in

                for column in tableProtocol.columns() {

                    switch (column.type) {
                    case .int?:
                        let exp = Expression<Int64>(column.name!)
                        tableColumn.column(exp)
                    case .real?:
                        let exp = Expression<Float64>(column.name!)
                        tableColumn.column(exp)
                    case .string?:
                        let exp = Expression<String>(column.name!)
                        tableColumn.column(exp)
                    case .primaryKey?:
                        let exp = Expression<Int64>(column.name!)
                        tableColumn.column(exp, primaryKey: .autoincrement)
                    case .foreignKey?:
                        
                        let foreignKey = Expression<Int64>((column.foreignKey?.key)!)
                        tableColumn.column(foreignKey)
                        let key = Expression<Int64>((column.foreignKey?.tableKey)!)
                        tableColumn.foreignKey(foreignKey, references: (column.foreignKey?.table)!, key, delete: .setNull)
                    default:
                        break
                    }
                }
            })

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
        do {
            try db?.prepare(query).run()
            return (db?.lastInsertRowid)!
        } catch {
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
    
}

extension SQLManager {
    
    /// Open connection with the database
    ///
    /// - Returns: Connection
    func openConnection() -> Connection? {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        do {
            let connect = try Connection("\(path)/database.db")
            try connect.key("umbrella")
            try connect.execute("PRAGMA foreign_keys = ON;")
            return connect
        } catch {
            print(error)
        }
        return nil
    }
    
    /// Copy the database if needed
    fileprivate func copyDatabaseIfNeeded() {
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        guard documentsUrl.count != 0 else {
            return
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent("database.db")
        
        if !( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            
            let documentsURL = Bundle.main.resourceURL?.appendingPathComponent("database.db")
            
            print(documentsURL ?? "")
            
            do {
                try fileManager.copyItem(atPath: (documentsURL?.path)!, toPath: finalDatabaseURL.path)
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
            
        } else {
            print("Database file found at path: \(finalDatabaseURL.path)")
        }
        
    }
}
