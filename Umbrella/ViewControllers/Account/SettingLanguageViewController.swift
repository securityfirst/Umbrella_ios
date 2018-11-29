//
//  SettingLanguageViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 23/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class SettingLanguageViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var settingLanguageViewModel: SettingLanguageViewModel = {
        let settingLanguageViewModel = SettingLanguageViewModel()
        return settingLanguageViewModel
    }()
    @IBOutlet weak var languageTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Languages".localized()
         NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
        let language = UserDefaults.standard.object(forKey: "Language") as? String
        
        self.settingLanguageViewModel.items.forEach { item in
            item.checked = (item.value == language)
        }
    }
    
    //
    // MARK: - Functions
    
    @objc func updateLanguage() {
        self.title = "Languages".localized()
        self.settingLanguageViewModel.loadItems()
        self.languageTableView.reloadData()
    }
    
    //
    // MARK: - Actions
}

// MARK: - UITableViewDataSource
extension SettingLanguageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingLanguageViewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SettingItemCell = (tableView.dequeueReusableCell(withIdentifier: "SettingItemCell", for: indexPath) as? SettingItemCell)!
        
        cell.configure(withViewModel: self.settingLanguageViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingLanguageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let itemSelected = self.settingLanguageViewModel.items[indexPath.row]
        
        self.settingLanguageViewModel.items.forEach { item in
            item.checked = false
            
            if item.name == itemSelected.name {
                item.checked = true
            }
        }
        
        UserDefaults.standard.set(itemSelected.value, forKey: "Language")
        Localize.setCurrentLanguage(itemSelected.value)
        
        tableView.reloadData()
        
        self.navigationController?.popViewController(animated: true)
    }
}
