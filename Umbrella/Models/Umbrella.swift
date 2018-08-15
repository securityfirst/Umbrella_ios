//
//  Umbrella.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

class Umbrella {
    
    //
    // MARK: - Properties
    let languages: [Language]
    let forms: [Form]
    var formAnswers: [FormAnswer]
    
    //
    // MARK: - Initializers
    init() {
        self.languages = []
        self.forms = []
        self.formAnswers = []
    }
    
    init(languages: [Language], forms: [Form], formAnswers: [FormAnswer]) {
        self.languages = languages
        self.forms = forms
        self.formAnswers = formAnswers
    }
}
