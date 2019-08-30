//
//  FormMatrix.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/08/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct FormMatrix: MatrixFile {
    
    var form: Form?
    let url: URL!
    
    init(url: URL) {
        self.url = url
        self.form = Form()
    }
    
    mutating func convert() -> Bool {
        do {
            let json = try String(contentsOf: self.url)
            let object = try JSONDecoder().decode(Form.self, from: json.data(using: .utf8)!)
            self.form = object
            return self.form?.screens.count ?? 0 > 0
        } catch {
            print(error)
            return false
        }
    }
    
    func updateDB() {
        print("Form UpdateDB")
        
        
        
    }
    
    func openFile() {
        print("Form Open File")
    }
}
