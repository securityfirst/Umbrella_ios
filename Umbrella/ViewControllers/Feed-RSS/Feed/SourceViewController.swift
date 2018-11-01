//
//  SourceViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

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
        
        let sources = UserDefaults.standard.object(forKey: "Sources") as? [Int]
        
        if sources != nil {
            sources?.forEach { index in
             self.selectedIndexPaths.insert(IndexPath(row: index, section: 0))
            }
        }
        self.sourceTableView.reloadData()
    }
    
    //
    // MARK: - Actions
    
    @IBAction func saveAction(_ sender: Any) {
        if self.selectedIndexPaths.count == 0 {
            return
        }
        
        NotificationCenter.default.post(name: Notification.Name("ContinueWizard"), object: nil)
        
        var indexs: [Int] = [Int]()
        for indexPath in self.selectedIndexPaths {
            indexs.append(indexPath.row)
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
        return Sources.list.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SourceCell = (tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as? SourceCell)!
        
        let source = Sources.list[indexPath.row]
        cell.titleLabel?.text = source.name
        
        cell.checkImageView.image = self.selectedIndexPaths.contains(indexPath) ? #imageLiteral(resourceName: "checkSelected") : #imageLiteral(resourceName: "groupNormal")
        
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
        
        if self.selectedIndexPaths.contains(indexPath) {
            self.selectedIndexPaths.remove(indexPath)
        } else {
            self.selectedIndexPaths.insert(indexPath)
        }
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}
