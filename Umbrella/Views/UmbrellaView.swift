//
//  UmbrellaView.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

@IBDesignable
class UmbrellaView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cornerRadius = 14
        self.shadowRadius = 10
        self.shadowOpacity = 8
        self.shadowOffset = CGSize(width: 1, height: 1)
        self.shadowColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.8078431373, alpha: 1)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.cornerRadius = 14
        self.shadowRadius = 10
        self.shadowOpacity = 8
        self.shadowOffset = CGSize(width: 1, height: 1)
        self.shadowColor = #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.8078431373, alpha: 1)
    }
}
