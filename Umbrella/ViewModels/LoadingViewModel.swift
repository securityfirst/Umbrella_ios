//
//  LoadingViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Files

class LoadingViewModel {
    
    //
    // MARK: - Properties
    var languages: [Language]
    var forms: [Form]
    var sqlManager: SQLManager
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
        self.languages = []
        self.forms = []
        self.sqlManager = SQLManager(databaseName: "database.db", password: "umbrella")
    }
    
    //
    // MARK: - Functions
    
    /// Parse of tent
    func parseTent(completion: @escaping (Float) -> Void) {
        
        //Umbrella Parse of Tent
        var umbrellaParser = UmbrellaParser(documentsFolder: documentsFolder)
        umbrellaParser.parse { languages, forms in
            self.languages = languages
            self.forms = forms
            let umbrellaDatabase = UmbrellaDatabase(languages: self.languages, forms: self.forms, sqlProtocol: sqlManager)
            _ = umbrellaDatabase.dropTables()
            umbrellaDatabase.objectToDatabase(completion: { progress in
                completion(progress)
            })
        }
    }
    
    /// Load whole object from database to object
    func loadUmbrellaOfDatabase() {
        var umbrellaDatabase = UmbrellaDatabase(sqlProtocol: sqlManager)
        umbrellaDatabase.databaseToObject()
        self.languages = umbrellaDatabase.languages
        self.forms = umbrellaDatabase.forms
        
        NotificationCenter.default.post(name: Notification.Name("UmbrellaTent"), object: Umbrella(languages: self.languages, forms: self.forms))
    }
    
    /// Check if there is a clone
    ///
    /// - Parameter url: url of documents
    /// - Returns: boolean
    func checkIfExistClone(fileManager: FileManager = FileManager.default, pathDirectory: FileManager.SearchPathDirectory) -> Bool {
        let documentsUrl = fileManager.urls(for: pathDirectory, in: .userDomainMask)
        guard let url = documentsUrl.first else {
            return false
        }
        let gitManager = GitManager(url: url, pathDirectory: .documentDirectory)
        let finalDatabaseURL = url.appendingPathComponent("en")
        
        return gitManager.checkIfExistClone() && ((try? finalDatabaseURL.checkResourceIsReachable()) ?? false)
    }
    
    /// Clone of repository of the tent
    ///
    /// - Parameters:
    ///   - url: url of repository
    ///   - completion: closure of progress
    func clone(witUrl url: URL, completion: @escaping (Float) -> Void, failure: @escaping ((Error) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            
            let gitManager = GitManager(url: url, pathDirectory: .documentDirectory)
            gitManager.clone(completion: { (totalBytesWritten, totalBytesExpectedToWrite) in
                let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
                completion(progress)
            }, failure: { error in
                print("GitManager: \(error)")
                failure(error)
            })
        }
    }
}
