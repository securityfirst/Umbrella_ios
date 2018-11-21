//
//  SettingSourcesViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class SettingSourcesViewController: UIViewController {

    //
    // MARK: - Properties
    lazy var settingSourceViewModel: SettingSourceViewModel = {
        let settingSourceViewModel = SettingSourceViewModel()
        return settingSourceViewModel
    }()
    var selectedIndexPaths: Set<IndexPath> = Set<IndexPath>()
    
    @IBOutlet weak var settingSourceTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sources = UserDefaults.standard.object(forKey: "Sources") as? [Int]
        
        if sources != nil {
            sources?.forEach { index in
                
                let item = self.settingSourceViewModel.items[index]
                item.checked = true
                self.selectedIndexPaths.insert(IndexPath(row: index, section: 0))
            }
        }
    
        self.settingSourceTableView.reloadData()
    }
    
    //
    // MARK: - Functions
    
    //
    // MARK: - Actions
}

// MARK: - UITableViewDataSource
extension SettingSourcesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingSourceViewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SettingItemCell = (tableView.dequeueReusableCell(withIdentifier: "SettingItemCell", for: indexPath) as? SettingItemCell)!
        
        cell.configure(withViewModel: self.settingSourceViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingSourcesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let itemSelected = self.settingSourceViewModel.items[indexPath.row]
        
        if self.selectedIndexPaths.contains(indexPath) {
            self.selectedIndexPaths.remove(indexPath)
            itemSelected.checked = false
        } else {
            self.selectedIndexPaths.insert(indexPath)
            itemSelected.checked = true
        }
        
        var indexs: [Int] = [Int]()
        for indexPath in self.selectedIndexPaths {
            indexs.append(indexPath.row)
        }
        NotificationCenter.default.post(name: Notification.Name("UpdateSources"), object: nil, userInfo: ["sources": indexs])
        
        UserDefaults.standard.set(indexs, forKey: "Sources")
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        
    }
}
