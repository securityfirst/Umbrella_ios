//
//  TabBar.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

@IBDesignable
class TabBar: UITabBar {

    @IBInspectable
    var color: UIColor = UIColor.darkGray {
        didSet {
            unselectedItemTintColor = color
        }
    }
    
    override func awakeFromNib() {
        unselectedItemTintColor = color
        
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        unselectedItemTintColor = color
    }

}
