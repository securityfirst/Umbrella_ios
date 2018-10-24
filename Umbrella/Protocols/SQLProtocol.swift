//
//  SQLProtocol.swift
//  Umbrella
//
//  Created by Lucas Correa on 02/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

protocol SQLProtocol {
    func select<T: Decodable>(withQuery query:String) -> [T]
    func select(withQuery query:String) -> [[String: Any]]
    
    func create(table tableProtocol: TableProtocol) -> Bool
    func remove(withQuery query:String) -> Bool
    func insert(withQuery query:String) -> Int64
    func drop(tableName table: String) -> Bool
    
    func checkIfTheDatabaseExists() -> Bool
    func resetConnection()
}
