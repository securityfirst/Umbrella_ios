//
//  DeepLinkParser.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/02/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class DeepLinkParser {
    
    static let shared = DeepLinkParser()
    private init() { }
    
    func parseDeepLink(_ url: URL) -> (DeepLinkType, String?, String?) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            return (.none, nil, nil)
        }
        
        var pathComponents = components.path.components(separatedBy: "/")
        
        // the first component is empty
        pathComponents.removeFirst()
        
        switch host {
        case "lesson":
            if pathComponents.count == 1 {
                if let subCategory = pathComponents.first {
                    return (type:.lesson, category: subCategory, difficulty: nil)
                }
            } else {
                // Has specify difficulty level
                if let subCategory = pathComponents.first, let difficulty = pathComponents.last {
                    return (type:.lesson, category: subCategory, difficulty: difficulty)
                }
            }
        case "forms":
            if let formName = pathComponents.first {
                return (type:.form, formName: formName, nil)
            } else {
                return (type:.form, formName: "", nil)
            }
        case "feed":
            return (type:.feed, nil, nil)
        case "checklist":
            return (type:.checklist, nil, nil)
        default:
            break
        }
        return (.none, nil, nil)
    }
}
