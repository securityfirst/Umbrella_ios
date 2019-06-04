//
//  PathwayDao.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

struct PathwayDao {
    
    //
    // MARK: - Properties
    let sqlProtocol: SQLProtocol
    
    //
    // MARK: - Initializer
    
    /// Init
    ///
    /// - Parameter sqlProtocol: SQLProtocol
    init(sqlProtocol: SQLProtocol) {
        self.sqlProtocol = sqlProtocol
    }

    /// List of object
    ///
    /// - Returns: a list of object
    func list(languageId: Int) -> Category {
        
        let categories:[Category] = self.sqlProtocol.select(withQuery: "SELECT id, name as title, \"index\", folder_name, deeplink, parent, language_id FROM category WHERE name = '\("Pathways".localized())' AND language_id = \(languageId)")
        
        for category in categories {
            let checklists:[CheckList] = self.sqlProtocol.select(withQuery: "SELECT id, name as title, \"index\", category_id FROM checklist WHERE category_id = \(category.id)")
            category.checkLists = checklists
            
            for checklist in checklists {
                let checkItems:[CheckItem] = self.sqlProtocol.select(withQuery: "SELECT id, name as \"check\", is_label, checklist_id FROM check_item WHERE checklist_id = \(checklist.id)")
                checklist.items = checkItems
            }
        }
    
        if let category = categories.first {
            return category
        }
        
        return Category()
    }

}
