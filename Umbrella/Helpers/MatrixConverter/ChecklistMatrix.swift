//
//  ChecklistMatrix.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/08/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct ChecklistMatrix: MatrixFile {
    
    var checklist: CheckList?
    let url: URL!
    
    init(url: URL) {
        self.url = url
        self.checklist = CheckList()
    }
    
    mutating func convert() -> Bool {
        do {
            let json = try String(contentsOf: self.url)
            let object = try JSONDecoder().decode(CheckList.self, from: json.data(using: .utf8)!)
            self.checklist = object
            return self.checklist?.items.count ?? 0 > 0
        } catch {
            print(error)
            return false
        }
    }
    
    func updateDB() {
        print("Checklist UpdateDB")
    }
    
    func openFile() {
        print("Checklist Open File")
    }
}
