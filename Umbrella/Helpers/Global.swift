//
//  Global.swift
//  Umbrella
//
//  Created by Lucas Correa on 20/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files

//
// MARK: - Property
var documentsFolder: Folder = {
    let system = FileSystem()
    let path = system.homeFolder.path
    var documents: Folder?
    do {
        let folder = try Folder(path: path)
        documents = try folder.subfolder(named: "Documents")
    } catch {
        print(error)
    }
    return documents!
}()

//
// MARK: - Function
func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
    
}
