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
    
    //
    // MARK: - Functions
    
    /// Load all forms by languageId
    ///
    /// - Parameter languageId: Int
    /// - Returns: [Form]
    func loadFormByCurrentLanguage() -> [Form] {
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        
        var language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        
        if language == nil {
            // if language doesn't exist get the default en - English
            language = UmbrellaDatabase.languagesStatic.filter { $0.name == "en" }.first
        }
        
        return self.forms.filter { $0.languageId == language?.id}
    }
    
    /// Load all formAnswers by current language
    ///
    /// - Parameter languageId: Int
    /// - Returns: [Form]
    func loadFormAnswersByCurrentLanguage() -> [FormAnswer] {
        let forms = loadFormByCurrentLanguage()
        var formAnswersLocal = [FormAnswer]()
        
        forms.forEach { form in
            formAnswersLocal += self.formAnswers.filter { $0.formId == form.id }
        }
        return formAnswersLocal
    }
}
