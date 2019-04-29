//
//  SettingsViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class SettingsViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var settingsViewModel: SettingsViewModel = {
        let settingsViewModel = SettingsViewModel()
        return settingsViewModel
    }()
    
    @IBOutlet weak var settingsTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Settings".localized()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.settingsTableView.reloadData()
    }
    
    //
    // MARK: - Functions
    
    @objc func updateLanguage() {
        self.title = "Settings".localized()
        self.settingsViewModel.loadItems()
        self.settingsTableView.reloadData()
    }
    
    /// Refresh data of the repository
    fileprivate func refreshRepo() {
        let repository = (UserDefaults.standard.object(forKey: "repository") as? String)!
        let gitManager = GitManager(url: URL(string: repository)!, pathDirectory: .documentDirectory)
        
        UserDefaults.standard.set(false, forKey: "passwordCustom")
        UserDefaults.standard.synchronize()
        
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
    }
    
    /// Import data
    fileprivate func importData() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.database"], in: .import)
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    /// Export data
    fileprivate func exportData() {
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        guard documentsUrl.count != 0 else {
            return
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(Database.name)
        
        let activityVC = UIActivityViewController(activityItems: [finalDatabaseURL], applicationActivities: nil)
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.copyToPasteboard]
        
        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                return
            }
            // User completed activity
        }
        
        self.present(activityVC, animated: true, completion: nil)
    }
    
    /// Select another language
    fileprivate func selectLanguage() {
        self.performSegue(withIdentifier: "languageSegue", sender: nil)
    }
    
    /// Select another language
    fileprivate func changeRepository() {
        let app = (UIApplication.shared.delegate as? AppDelegate)!
        app.show()
    }
    
    /// Change interval to update the feed
    fileprivate func refreshInterval() {
        self.performSegue(withIdentifier: "intervalSegue", sender: nil)
    }
    
    /// Change location to update the feed
    fileprivate func selectLocation() {
        self.performSegue(withIdentifier: "locationSegue", sender: nil)
    }
    
    /// Change sources to update the feed
    fileprivate func selectFeedSources() {
        self.performSegue(withIdentifier: "sourcesSegue", sender: nil)
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableSection.total.rawValue
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let tableSection = TableSection(rawValue: section), let movieData = self.settingsViewModel.items[tableSection] {
            return movieData.count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SettingCell = (tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as? SettingCell)!
        
        cell.configure(withViewModel: self.settingsViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if let tableSection = TableSection(rawValue: section), let movieData = self.settingsViewModel.items[tableSection], movieData.count > 0 {
            return 40
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 40))
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 15, y: 10, width: tableView.bounds.width - 30, height: 25))
        label.font = UIFont(name: "Roboto-Regular", size: 14)
        label.textColor = UIColor.gray
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .general:
                label.text = "GENERAL".localized()
            case .feed, .feed2:
                label.text = "FEED".localized()
            default:
                label.text = ""
            }
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // General
        if indexPath.section == 0 {
            // Refresh
            if indexPath.row == 1 {
                refreshRepo()
            }
                // Repository
            else if indexPath.row == 2 {
                changeRepository()
            }
                // Language
            else if indexPath.row == 3 {
                selectLanguage()
            }
                // Import
            else if indexPath.row == 4 {
                importData()
            }
                // Export
            else if indexPath.row == 5 {
                exportData()
            }
            
        }
            // Feed
        else if indexPath.section == 1 {
            // Refresh Interval
            if indexPath.row == 0 {
                refreshInterval()
            }
                // Location
            else if indexPath.row == 1 {
                selectLocation()
            }
                // Feed sources
            else if indexPath.row == 2 {
                selectFeedSources()
            }
        }
    }
}

extension SettingsViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
        UIApplication.shared.keyWindow?.addSubview(controller.view)
        
        DispatchQueue.global(qos: .default).async {
            let fileManager = FileManager.default
            let documentsUrl = fileManager.urls(for: .documentDirectory,
                                                in: .userDomainMask)
            guard documentsUrl.count != 0 else {
                return
            }
            
            do {
                let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(Database.name)
                
                _ = try fileManager.replaceItemAt(finalDatabaseURL, withItemAt: url)
                let result = self.settingsViewModel.updateDatabaseToObject()
                
                DispatchQueue.main.async {
                    controller.view.removeFromSuperview()
                    
                    //Update all screen that Subscribe this notification
                    NotificationCenter.default.post(name: Notification.Name("UmbrellaTent"), object: Umbrella(languages: result.languages, forms: result.forms, formAnswers: result.formAnswers))
                }
                
            } catch let error as NSError {
                print("Couldn't copy file to final location! Error:\(error.description)")
            }
        }
    }
}
