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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
       
    }
}
