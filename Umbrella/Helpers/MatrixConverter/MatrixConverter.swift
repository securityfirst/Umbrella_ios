//
//  MatrixConverter.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/08/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

protocol MatrixFile {
    mutating func convert() -> Bool
    func updateDB()
    func openFile()
}

struct MatrixConverter {
    
    let url: URL!
    var matrixFile: MatrixFile?
    
    init(url: URL) {
         self.url = url
    }
    
    mutating func convert() {
        
        var formMatrix = FormMatrix(url: self.url)
        var checklistMatrix = ChecklistMatrix(url: self.url)
        
        if checklistMatrix.convert() {
            self.matrixFile = checklistMatrix
        }
        
        if formMatrix.convert() {
            self.matrixFile = formMatrix
        }
    }
    
    func updateDB() {
        self.matrixFile?.updateDB()
    }
    
    func openFile() {
        self.matrixFile?.openFile()
    }
}
