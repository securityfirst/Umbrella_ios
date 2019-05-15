//
//  DemoSettingViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 10/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Files
import Localize_Swift

class DemoSettingViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var gitText: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
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
        
        updateLanguage()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    @objc func updateLanguage() {
        self.titleLabel.text = "Change repository".localized()
        self.messageLabel.text = "Loading data from new repository will reset all the progress you made. Back up before you do it!".localized()
        self.segmentedControl.setTitle("Security First".localized(), forSegmentAt: 0)
        self.segmentedControl.setTitle("Secondary".localized(), forSegmentAt: 1)
        self.changeButton.setTitle("Change".localized(), for: .normal)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.view.isHidden = true
        self.view.endEditing(true)
    }
    
    @IBAction func changeAction(_ sender: Any) {
        
        var url = ""
        if segmentedControl.selectedSegmentIndex == 0 {
            url = "https://github.com/securityfirst/umbrella-content"
        } else if segmentedControl.selectedSegmentIndex == 1 {
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
         
            self.view.isHidden = true
            self.view.endEditing(true)
            
            UserDefaults.standard.set(url, forKey: "repository")
            UserDefaults.standard.set(false, forKey: "passwordCustom")
            UserDefaults.standard.synchronize()
            
            let repository = (UserDefaults.standard.object(forKey: "repository") as? String)!
            let gitManager = GitManager(url: URL(string: repository)!, pathDirectory: .documentDirectory)
            
            do {
                try gitManager.deleteCloneInFolder(pathDirectory: .documentDirectory)
                
                NotificationCenter.default.post(name: Notification.Name("ResetRepository"), object: nil)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
                UIApplication.shared.keyWindow?.addSubview(controller.view)
                controller.loadTent {
                    print("Finished load tent")
                }
            } catch {
                print(error)
            }
        } else {
            self.view.isHidden = true
            self.view.endEditing(true)
        }
    }
}
