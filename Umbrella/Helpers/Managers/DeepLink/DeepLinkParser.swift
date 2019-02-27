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
    
    func parseDeepLink(_ url: URL) -> ResultDeepLink {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), let host = components.host else {
            return ResultDeepLink(type: .none)
        }
        
        var pathComponents = components.path.components(separatedBy: "/")
        
        // the first component is empty
        pathComponents.removeFirst()
        
        switch host {
        case "forms":
            if let fileName = pathComponents.first {
                return ResultDeepLink(type: .form, file: fileName)
            } else {
                return ResultDeepLink(type: .form)
            }
        case "feed":
            return ResultDeepLink(type: .feed)
        case "checklist":
            return ResultDeepLink(type: .checklist)
        default:
            //lessons
            return parseLessons(host: host, pathComponents: pathComponents)
        }
    }
    
    /// Parse of lessons
    ///
    /// - Parameters:
    ///   - host: String
    ///   - pathComponents: [String]
    /// - Returns: ResultDeepLink
    func parseLessons(host: String, pathComponents: [String]) -> ResultDeepLink {
        if pathComponents.count == 1 {
            if let object = pathComponents.first {
                if object.contains(".md") {
                    // umbrella://glossary/s_two-factor-authentication.md
                    return ResultDeepLink(type: .lesson, category: host, subCategory: nil, difficulty: nil, file: object)
                } else {
                    // umbrella://information/malware
                    return ResultDeepLink(type: .lesson, category: host, subCategory: object, difficulty: nil, file: nil)
                }
            }
        } else if pathComponents.count == 2 {
            if let subCategory = pathComponents.first, let object = pathComponents.last {
                if object.contains(".md") {
                    // umbrella://tools/messagging/s_mailvelope.md
                    return ResultDeepLink(type: .lesson, category: host, subCategory: subCategory, difficulty: nil, file: object)
                } else {
                    // umbrella://communications/email/beginner
                    return ResultDeepLink(type: .lesson, category: host, subCategory: subCategory, difficulty: object, file: nil)
                }
            }
        } else if pathComponents.count == 3 {
            // umbrella://communications/mobile-phones/beginner/s_burner-phones.md
            if let subCategory = pathComponents.first, let file = pathComponents.last {
                let difficulty = pathComponents[1]
                return ResultDeepLink(type: .lesson, category: host, subCategory: subCategory, difficulty: difficulty, file: file)
            }
        }
        
        return ResultDeepLink(type: .none)
    }
}
