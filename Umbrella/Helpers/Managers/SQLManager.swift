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
    
    // SELECT
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
    
    // CREATE
    func create(table tableProtocol: TableProtocol) -> Bool {
        let db = openConnection()
        do {
            let table = Table(tableProtocol.tableName)
            try db?.run(table.create { tableColumn in

                for dic in tableProtocol.columns() {

                    switch (dic.value) {
                    case "Int":
                        let exp = Expression<Int64>(dic.key)
                        tableColumn.column(exp)
                    case "String":
                        let exp = Expression<String>(dic.key)
                        tableColumn.column(exp)
                    case "Primary":
                        let exp = Expression<Int64>(dic.key)
                        tableColumn.column(exp, primaryKey: .autoincrement)
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
    
    // INSERT
    func insert(withQuery query:String) -> Bool {
        let db = openConnection()
        do {
            try db?.prepare(query).run()
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    // DROP
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
    
    func openConnection() -> Connection? {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        do {
            let connect = try Connection("\(path)/database.db")
            try connect.key("umbrella")
            return connect
        } catch {
            print(error)
        }
        return nil
    }
    
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
