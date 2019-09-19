//
//  MatrixFile.swift
//  Umbrella
//
//  Created by Lucas Correa on 02/09/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct MatrixFile {
    
    var matrixType: String
    var language: String
    var name: String
    var extra: String
    var object: Any?
    
    init() {
        self.matrixType = ""
        self.language = ""
        self.name = ""
        self.extra = ""
        self.object = nil
    }
}

extension MatrixFile: Codable {
    
    //
    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case matrixType = "matrix_type"
        case language
        case name
        case extra
        case object
    }
    
     init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.matrixType = try container.decodeIfPresent(String.self, forKey: .matrixType) ?? ""
        self.language = try container.decodeIfPresent(String.self, forKey: .language) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.extra = try container.decodeIfPresent(String.self, forKey: .extra) ?? ""
        
        if self.matrixType == "form" {
            self.object = try container.decodeIfPresent(Form.self, forKey: .object) ?? Form()
        } else if self.matrixType == "checklist" {
            self.object = try container.decodeIfPresent(CheckList.self, forKey: .object) ?? CheckList()
        } else if self.matrixType == "customChecklist" {
            self.object = try container.decodeIfPresent(CustomChecklist.self, forKey: .object) ?? CheckList()
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(matrixType, forKey: .matrixType)
        try container.encode(language, forKey: .language)
        try container.encode(name, forKey: .name)
        try container.encode(extra, forKey: .extra)
        
        if self.matrixType == "form" {
            try container.encode(object as? Form, forKey: .object)
        } else if self.matrixType == "checklist" {
            try container.encode(object as? CheckList, forKey: .object)
        } else if self.matrixType == "customChecklist" {
            try container.encode(object as? CustomChecklist, forKey: .object)
        }
        
    }
}
