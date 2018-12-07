//
//  DemoSettingViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 10/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Files

class DemoSettingViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var gitText: UITextField!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gitText.text = "https://github.com/"
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.view.isHidden = true
        self.view.endEditing(true)
    }
    
    @IBAction func changeAction(_ sender: Any) {
        
        var url = ""
        if segmentedControl.selectedSegmentIndex == 0 {
            print("0")
            url = "https://github.com/securityfirst/umbrella-content"
        } else if segmentedControl.selectedSegmentIndex == 1 {
            print("1")
            url = "https://github.com/klaidliadon/umbrella-content"
        }
        
        if let text = gitText.text {
            if text.count > 19 {
                if text.contains("https://github.com/") {
                    url = text
                }
            }
        }
        
        gitText.text = "https://github.com/"
        
        let repository = (UserDefaults.standard.object(forKey: "repository") as? String)!
        
        if repository != url {
         
            UserDefaults.standard.set(url, forKey: "repository")
            UserDefaults.standard.set(false, forKey: "acceptTerm")
            UserDefaults.standard.synchronize()
        
            let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
            let umbrellaDatabase = UmbrellaDatabase(sqlProtocol: sqlManager)
            _ = umbrellaDatabase.dropTables()
            
            let gitManager = GitManager(url: URL(string: url)!, pathDirectory: .documentDirectory)
            
            do {
                try gitManager.deleteCloneInFolder(pathDirectory: .documentDirectory)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "TourViewController")
                self.present(controller, animated: false, completion: nil)
                NotificationCenter.default.post(name: Notification.Name("ResetRepository"), object: nil)
                self.view.isHidden = true
                self.view.endEditing(true)
//                exit(0)
            } catch {
                print(error)
            }
            
        } else {
            self.view.isHidden = true
            self.view.endEditing(true)
        }
    }
}
