//
//  Form.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import SQLite

class Form: Codable, TableProtocol {
    
    // Used in parser from the database to object
    var id: Int
    
    //
    // MARK: - Properties
    var name: String {
        if screens.count > 0 {
            return screens.first!.name
        }
        return ""
    }
    
    let screens: [Screen]
    
    //
    // MARK: - Initializers
    init() {
        self.id = -1
        self.screens = []
    }
    
    init(screens: [Screen]) {
        self.id = -1
        self.screens = screens
    }
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case id
        case screens
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.id) {
            self.id = try container.decode(Int.self, forKey: .id)
        } else {
            self.id = -1
        }
        
        if container.contains(.screens) {
            self.screens = try container.decode([Screen].self, forKey: .screens)
        } else {
            self.screens = []
        }
    }
    
    //
    // MARK: - TableProtocol
    static var table: String = "form"
    var tableName: String {
        return Form.table
    }
    
    func columns() -> [Column] {
        let array = [
            Column(name: "id", type: .primaryKey),
            Column(name: "name", type: .string)
        ]
        return array
    }
}
