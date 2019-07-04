//
//  SyncManager.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class SyncManager {
    
    static let shared = SyncManager()
    
    fileprivate lazy var chatSyncViewModel: ChatSyncViewModel = {
        let chatSyncViewModel = ChatSyncViewModel()
        return chatSyncViewModel
    }()
    
    fileprivate var timer: Timer?
    
    init() {
        self.timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(sync), userInfo: nil, repeats: true)
        sync()
    }
    
    @objc func sync() {
        self.chatSyncViewModel.sync(success: { (sync) in
            
            let sync = (sync as? Sync)!
            if sync.rooms.invite.keys.count > 0 {
                UserDefaults.standard.set(true, forKey: "SyncHasNewItem")
                UserDefaults.standard.set(sync.rooms.invite.keys.count, forKey: "BadgeNumber")
                UserDefaults.standard.synchronize()
                NotificationCenter.default.post(name: Notification.Name("SyncMatrix"), object: sync)
            }
        }, failure: { (response, object, error) in
            print(error ?? "")
        })
    }
    
}
