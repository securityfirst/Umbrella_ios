//
//  SourceViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class SourceViewController: UIViewController {
    
    //
    // MARK: - Properties
    var selectedIndexPaths: Set<IndexPath> = Set<IndexPath>()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sources".localized()
        
        self.titleLabel.text = "Select The Feed Sources".localized()
        
        let sources = UserDefaults.standard.object(forKey: "Sources") as? [Int]
        
        if sources != nil {
            for (index,source) in Sources.list.enumerated() {
                let result = sources?.filter { $0 == source.code }
                if let result = result, result.count > 0 {
                    self.selectedIndexPaths.insert(IndexPath(row: index, section: 0))
                }
            }
        }
        
        if sources?.count == Sources.list.count {
            //Added indexPath of "Select All" as checked
            self.selectedIndexPaths.insert(IndexPath(row: Sources.list.count, section: 0))
        }
        
        saveButton.setTitle("Save".localized(), for: .normal)
        self.sourceTableView.reloadData()
    }
    
    //
    // MARK: - Actions
    
    @IBAction func saveAction(_ sender: Any) {
        if self.selectedIndexPaths.count == 0 {
            return
        }
        
        NotificationCenter.default.post(name: Notification.Name("ContinueWizard"), object: nil)
        
        self.selectedIndexPaths.remove(IndexPath(row: Sources.list.count, section: 0))
        var indexs: [Int] = [Int]()
        for indexPath in self.selectedIndexPaths {
            let source = Sources.list[indexPath.row]
            indexs.append(source.code)
        }
        NotificationCenter.default.post(name: Notification.Name("UpdateSources"), object: nil, userInfo: ["sources": indexs])
        
        UserDefaults.standard.set(indexs, forKey: "Sources")
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITableViewDataSource
extension SourceViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Sources.list.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SourceCell = (tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as? SourceCell)!
        
        if Sources.list.count == indexPath.row {
            cell.titleLabel?.text = "Select All".localized()
            cell.checkImageView.image = self.selectedIndexPaths.contains(indexPath) ? #imageLiteral(resourceName: "checkSelected") : #imageLiteral(resourceName: "groupNormal")
        } else {
            let source = Sources.list[indexPath.row]
            cell.titleLabel?.text = source.name
            cell.checkImageView.image = self.selectedIndexPaths.contains(indexPath) ? #imageLiteral(resourceName: "checkSelected") : #imageLiteral(resourceName: "groupNormal")
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SourceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if Sources.list.count == indexPath.row {
            let sourceIndexes = Sources.list.indices
            self.selectedIndexPaths.removeAll()
            
            for index in sourceIndexes {
                self.selectedIndexPaths.insert(IndexPath(row: index, section: 0))
            }
            self.selectedIndexPaths.insert(IndexPath(row: Sources.list.count, section: 0))
            tableView.reloadData()
            return
        }
        
        if self.selectedIndexPaths.contains(indexPath) {
            self.selectedIndexPaths.remove(IndexPath(row: Sources.list.count, section: 0))
            self.selectedIndexPaths.remove(indexPath)
        } else {
            self.selectedIndexPaths.insert(indexPath)
            
            if self.selectedIndexPaths.count == Sources.list.count {
                self.selectedIndexPaths.insert(IndexPath(row: Sources.list.count, section: 0))
            }
        }
        
        tableView.reloadRows(at: [indexPath, IndexPath(row: Sources.list.count, section: 0)], with: UITableView.RowAnimation.automatic)
    }
}
