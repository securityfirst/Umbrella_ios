//
//  NotificationCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

protocol NotificationCellDelegate: class {
    func onAccept(roomId: String)
    func onReject(roomId: String)
}

class NotificationCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    weak var delegate: NotificationCellDelegate?
    var roomId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - indexPath: IndexPath
    func configure(invite:[[String: Invite]], indexPath: IndexPath) {
        
        if invite.indexExists(indexPath.row) {
            let item = invite[indexPath.row]
            self.roomId = item.keys.first
            
            let invite = (item.values.first)!
            
            var group = ""
            var invitedBy = ""
            for inviteStateEvent in invite.inviteState.events {
                if inviteStateEvent.type == "m.room.name" {
                    if let name = inviteStateEvent.content.name {
                        group = name.capitalized
                    }
                } else if inviteStateEvent.type == "m.room.member" {
                    if inviteStateEvent.content.membership == "join" {
                        if let name = inviteStateEvent.content.displayname {
                            invitedBy = name.capitalized
                        }
                    }
                }
            }
            
            self.messageLabel.text = "\(invitedBy) has sent an invitation to join \(group)."
        }
    }

    @IBAction func rejectAction(_ sender: Any) {
        if let roomId = self.roomId {
            self.delegate?.onReject(roomId: roomId)
        }
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        if let roomId = self.roomId {
            self.delegate?.onAccept(roomId: roomId)
        }
    }
}
