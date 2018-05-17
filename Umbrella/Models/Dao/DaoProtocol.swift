//
//  DaoProtocol.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

protocol DaoProtocol {
    associatedtype TYPE
    
    func createTable() -> Bool
    func list() -> [TYPE]
    func dropTable() -> Bool
    func insert(_ object: TYPE) -> Bool
}
