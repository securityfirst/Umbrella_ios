//
//  SettingSourceViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

class SettingSourceViewModel: SettingCellProtocol {
    
    //
    // MARK: - Properties
    var items: [SettingItem]!
    
    //
    // MARK: - Init
    init() {
        
        self.items = []
        //            let source = Sources.list.filter { $0.code == index}.first
        //            if let source = source {
        //                stringBuffer.append("- \(source.name)\n")
        //            }
        //            self.sourceLegLabel.text = stringBuffer
        //            self.sourceLegLabel.textColor = #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1)
        //        }
        //
        for source in Sources.list {
            self.items.append(SettingItem(name: source.name, value: "\(source.code)", checked: false))
        }
        
        //        self.items = [
        //            SettingItem(name: "ReliefWeb / United Nations", value: "0", checked: false),
        //            SettingItem(name: "UK Foreign Office Country Warnings", value: "2", checked: false),
        //            SettingItem(name: "Centres for Disease Control (CDC)", value: "3", checked: false),
        //            SettingItem(name: "Global Disaster and Alert Coordination System", value: "4", checked: false),
        //            SettingItem(name: "US State Department Country Warnings", value: "5", checked: false)
        //        ]
    }
}
