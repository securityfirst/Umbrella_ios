//
//  NotificationViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var notificationTableView: UITableView!
    
    lazy var notificationViewModel: NotificationViewModel = {
        let notificationViewModel = NotificationViewModel()
        return notificationViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateList(_:)), name: NSNotification.Name("SyncedMatrix"), object: nil)
        
        self.tableHidden()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateList(_ notification:Notification) {
        self.notificationTableView.reloadData()
        
        self.tableHidden()
    }
    
    func tableHidden() {
        
        print(SyncManager.shared.invite.count)
        self.notificationTableView.isHidden = (SyncManager.shared.invite.count == 0)
        
        if let _ = notificationViewModel.getUserLogged() {
            
            let rule = UserDefaults.standard.bool(forKey: "ruleFirstLogin")
            let syncHasNewItem = UserDefaults.standard.bool(forKey: "SyncHasNewItem")
            
            if rule == false && syncHasNewItem {
                self.notificationTableView.isHidden = false
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension NotificationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let _ = notificationViewModel.getUserLogged() {
            let rule = UserDefaults.standard.bool(forKey: "ruleFirstLogin")
            if rule == false {
                return 2
            }
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return SyncManager.shared.invite.count
        }
        
        if section == 1 {
            return 1
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("\(indexPath)")
        if indexPath.section == 0 && SyncManager.shared.invite.count == 0 {
            let cell: RuleCell = (tableView.dequeueReusableCell(withIdentifier: "RuleCell", for: indexPath) as? RuleCell)!
            return cell
        }
        
        if indexPath.section == 1 {
            let cell: RuleCell = (tableView.dequeueReusableCell(withIdentifier: "RuleCell", for: indexPath) as? RuleCell)!
            return cell
        }
        
       let cell: NotificationCell = (tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell)!
        
        cell.configure(invite: SyncManager.shared.invite, indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension NotificationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - NotificationCellDelegate
extension NotificationViewController: NotificationCellDelegate {
    func onAccept(roomId: String) {
        self.notificationViewModel.joinRoom(roomId: roomId, success: { (response) in
            print(response ?? "")
            NotificationCenter.default.post(name: Notification.Name("StartSyncMatrix"), object: nil)
        }, failure: { (response, object, error) in
            print(error ?? "")
        })
    }
    
    func onReject(roomId: String) {
        self.notificationViewModel.leaveRoom(roomId: roomId, success: { (response) in
            print(response ?? "")
            NotificationCenter.default.post(name: Notification.Name("StartSyncMatrix"), object: nil)
        }, failure: { (response, object, error) in
            print(error ?? "")
        })
    }
}
