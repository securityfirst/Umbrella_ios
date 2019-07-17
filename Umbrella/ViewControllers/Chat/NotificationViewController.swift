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
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateList(_:)), name: NSNotification.Name("SyncMatrix"), object: nil)
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
        self.notificationTableView.isHidden = (SyncManager.shared.invite.count == 0)
    }
}

// MARK: - UITableViewDataSource
extension NotificationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SyncManager.shared.invite.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
            SyncManager.shared.sync()
        }, failure: { (response, object, error) in
            print(error ?? "")
        })
    }
    
    func onReject(roomId: String) {
        self.notificationViewModel.leaveRoom(roomId: roomId, success: { (response) in
            print(response ?? "")
            SyncManager.shared.sync()
        }, failure: { (response, object, error) in
            print(error ?? "")
        })
    }
}
