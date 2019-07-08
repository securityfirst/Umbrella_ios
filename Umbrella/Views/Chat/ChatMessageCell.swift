//
//  ChatMessageCell.swift
//  ChatBubble
//
//  Created by Lucas Correa on 25/06/2019.
//  Copyright © 2019 Lucas Correa. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {
    
    @IBOutlet weak var bubbleBackgroundView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = true
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:ChatMessageViewModel, indexPath: IndexPath) {
        
        let item = viewModel.messages[indexPath.section][indexPath.row]
        
        self.messageLabel.text = item.content.body
        self.timeLabel.text = item.hourFromMilliseconds()
        self.usernameLabel.text = item.username()
        self.usernameLabel.isHidden = item.isUserLogged
        self.bubbleBackgroundView.backgroundColor = item.isUserLogged ? #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1) : #colorLiteral(red: 0.8861995408, green: 0.8861995408, blue: 0.8861995408, alpha: 1)
        
        if let msgtype = item.content.msgtype {
            let type = RoomTypeMessage(rawValue: msgtype)
            
            switch type {
            case .text?:
                break
            case .file?:
                self.messageLabel.attributedText = NSAttributedString(string: item.content.body ?? "", attributes:
                    [.underlineStyle: NSUnderlineStyle.single.rawValue])
            default:
                break
            }
        }
        
        if item.isUserLogged {
            leadingConstraint.isActive = false
            trailingConstraint.isActive = true
        } else {
            leadingConstraint.isActive = true
            trailingConstraint.isActive = false
        }
    }
    
}
