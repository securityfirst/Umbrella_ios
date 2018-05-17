//
//  Category.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

struct Category: Codable, TableProtocol {
    let name: String?
    let difficultyBeginner: Int?
    let difficultyAdvanced: Int?
    let difficultyExpert: Int?
    let hasDifficulty: Int?
    let textBeginner: String?
    let textAdvanced: String?
    let textExpert: String?
    
    init() {
        name = ""
        difficultyBeginner = 0
        difficultyAdvanced = 0
        difficultyExpert = 0
        hasDifficulty = 0
        textBeginner = ""
        textAdvanced = ""
        textExpert = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "category"
        case difficultyBeginner
        case difficultyAdvanced
        case difficultyExpert
        case hasDifficulty
        case textBeginner
        case textAdvanced
        case textExpert
    }    
    
    //
    // MARK: - TableProtocol
    var tableName: String = "category"
    
    func columns() -> [String : String] {
        let array = [
            "id":"Primary",
            "category": "String",
            "difficultyAdvanced": "Int",
            "difficultyBeginner":"Int",
            "difficultyExpert":"Int",
            "hasDifficulty":"Int",
            "parent":"Int",
            "textAdvanced":"String",
            "textBeginner":"String",
            "textExpert":"String"
        ]
        return array
    }
}
