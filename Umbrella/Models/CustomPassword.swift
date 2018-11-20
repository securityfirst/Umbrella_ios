//
//  CustomPassword.swift
//  Umbrella
//
//  Created by Lucas Correa on 19/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class CustomPassword {
    
    //
    // MARK: - Properties
    static let shared = CustomPassword()
    
    // This attribute is change by Login screen
    var password: String = ""
    
}
