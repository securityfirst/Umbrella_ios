//
//  SettingIntervalViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 20/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class SettingIntervalViewController: UIViewController {

    //
    // MARK: - Properties
    lazy var settingIntervalViewModel: SettingIntervalViewModel = {
        let settingIntervalViewModel = SettingIntervalViewModel()
        return settingIntervalViewModel
    }()
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let interval = UserDefaults.standard.object(forKey: "Interval") as? String
        
        self.settingIntervalViewModel.items.forEach { item in
            item.checked = (item.value == interval)
        }
    }
    
    //
    // MARK: - Functions
    
    //
    // MARK: - Actions
}

// MARK: - UITableViewDataSource
extension SettingIntervalViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingIntervalViewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SettingItemCell = (tableView.dequeueReusableCell(withIdentifier: "SettingItemCell", for: indexPath) as? SettingItemCell)!
        
        cell.configure(withViewModel: self.settingIntervalViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingIntervalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let itemSelected = self.settingIntervalViewModel.items[indexPath.row]
        
        self.settingIntervalViewModel.items.forEach { item in
            item.checked = false
            
            if item.name == itemSelected.name {
                item.checked = true
            }
        }
        
        NotificationCenter.default.post(name: Notification.Name("UpdateInterval"), object: nil, userInfo: ["interval": itemSelected.value])
        UserDefaults.standard.set(itemSelected.value, forKey: "Interval")
        
        tableView.reloadData()
    }
}
