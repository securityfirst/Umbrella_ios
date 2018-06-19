//
//  HomeViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files

class HomeViewModel {
    
    //
    // MARK: - Properties
    var languages: [Language]
    var forms: [Form]
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
    // MARK: - Init
    init() {
        languages = []
        forms = []
    }
    
    //
    // MARK: - Functions
    
    /// Parse of tent
    func parseTent() {
        
        //Umbrella Parse of Tent
        var umbrellaParser = UmbrellaParser(documentsFolder: documentsFolder)
        umbrellaParser.parse { languages, forms in
            self.languages = languages
            self.forms = forms
        }
        
    }
    
    /// Clone of repository of the tent
    ///
    /// - Parameters:
    ///   - url: url of repository
    ///   - completion: closure of progress
    func clone(witUrl url: String, completion: @escaping (Float) -> Void) {
        DispatchQueue.global(qos: .background).async {
            
            let gitManager = GitManager(urlString: url, pathDirectory: .documentDirectory)
            gitManager.clone(completion: { (totalBytesWritten, totalBytesExpectedToWrite) in
                let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
                completion(progress)
            }, failure: { error in
                print("GitManager: \(error)")
            })
        }
    }
}
