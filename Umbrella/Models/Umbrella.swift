//
//  Umbrella.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Umbrella {
    
    let languages: [Language]
    let forms: [Form]
    
    init() {
        self.languages = []
        self.forms = []
    }
    
    init(languages: [Language], forms: [Form]) {
        self.languages = languages
        self.forms = forms
    }
}
