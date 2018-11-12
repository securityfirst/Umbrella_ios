//
//  SettingsViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func refreshRepo() {
        let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        let umbrellaDatabase = UmbrellaDatabase(sqlProtocol: sqlManager)
        _ = umbrellaDatabase.dropTables()
        
        let gitHubDemo = (UserDefaults.standard.object(forKey: "gitHubDemo") as? String)!
        let gitManager = GitManager(url: URL(string: gitHubDemo)!, pathDirectory: .documentDirectory)
        
        do {
            try gitManager.deleteCloneInFolder(pathDirectory: .documentDirectory)
            
            NotificationCenter.default.post(name: Notification.Name("ResetDemo"), object: nil)
            
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
    
    fileprivate func selectLanguage() {
        
    }
    
    fileprivate func importData() {
        
    }
    
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
    
    fileprivate func refreshInterval() {
        
    }

    fileprivate func selectLocation() {
        
    }
    
    fileprivate func selectFeedSources() {
        
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
                label.text = "GENERAL"
            case .feed, .feed2:
                label.text = "FEED"
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
                // Language
            else if indexPath.row == 2 {
                selectLanguage()
            }
                // Import
            else if indexPath.row == 3 {
                importData()
            }
                // Export
            else if indexPath.row == 4 {
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
