//
//  ChatRequestViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 01/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

enum ChatRequestType : String {
    case forms
    case checklists
    case answers
    case file
    case invite
}

class ChatRequestViewModel {
    
    //
    // MARK: - Properties
    var items: [(name: String, type: ChatRequestType, icon: UIImage)]!
    var userLogged: UserMatrix!
    var room: Room!
    
    init() {
        
    }
    
    func loadItems() {
        self.items = [
            (name: "Forms".localized(), type: ChatRequestType.forms, icon: #imageLiteral(resourceName: "icMap")),
            (name: "Checklists".localized(), type: ChatRequestType.checklists, icon: #imageLiteral(resourceName: "icDoneAll")),
//            (name: "Answers".localized(), type: ChatRequestType.answers, icon: #imageLiteral(resourceName: "iconFavourite")),
            (name: "File".localized(), type: ChatRequestType.file, icon: #imageLiteral(resourceName: "rssListChoice")),
            (name: "Invite user".localized(), type: ChatRequestType.invite, icon: UIImage())
        ]
    }
}
