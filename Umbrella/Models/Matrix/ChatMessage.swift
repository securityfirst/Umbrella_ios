//
//  ChatMessage.swift
//  ChatBubble
//
//  Created by Lucas Correa on 25/06/2019.
//  Copyright © 2019 Lucas Correa. All rights reserved.
//

import Foundation

struct ChatMessage: Codable {
    let messages: [ChatMessageChunk]
    let start, end: String
    
    enum CodingKeys: String, CodingKey {
        case messages = "chunk"
        case start, end
    }
}

class ChatMessageChunk: Codable, NSCopying {
    
    var type: String
    var roomId: String
    var originTime: Int
    var content: Content
    var age: Int
    var userId: String
    var isUserLogged: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case type
        case roomId = "room_id"
        case content
        case originTime = "origin_server_ts"
        case userId = "user_id"
        case age
    }
    
    //
    // MARK: - Initializers
    init() {
        self.type = ""
        self.roomId = ""
        self.originTime = 0
        self.content = Content()
        self.age = 0
        self.userId = ""
        self.isUserLogged = false
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if container.contains(.age) {
            self.age = try container.decode(Int.self, forKey: .age)
        } else {
            self.age = -1
        }
        
        if container.contains(.type) {
            self.type = try container.decode(String.self, forKey: .type)
        } else {
            self.type = ""
        }
        
        if container.contains(.roomId) {
            self.roomId = try container.decode(String.self, forKey: .roomId)
        } else {
            self.roomId = ""
        }
        
        if container.contains(.originTime) {
            self.originTime = try container.decode(Int.self, forKey: .originTime)
        } else {
            self.originTime = 0
        }
        
        if container.contains(.content) {
            self.content = try container.decode(Content.self, forKey: .content)
        } else {
            self.content = Content()
        }
        
        if container.contains(.userId) {
            self.userId = try container.decode(String.self, forKey: .userId)
        } else {
            self.userId = ""
        }
    }
    
    //
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = ChatMessageChunk()
        copy.type = self.type
        copy.roomId = self.roomId
        copy.originTime = self.originTime
        copy.content = self.content
        copy.age = self.age
        copy.userId = self.userId
        copy.isUserLogged = self.isUserLogged
        return copy
    }
    
    func millisecondsToDate() -> Date {
        let date = Date(timeIntervalSince1970: Double(originTime) / 1000)
        return date
    }
    
    func dateFromMilliseconds() -> String {
        let date = Date(timeIntervalSince1970: Double(originTime) / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func hourFromMilliseconds() -> String {
        let date = Date(timeIntervalSince1970: Double(originTime) / 1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    func username() -> String {
        do {
            
            let regex = try NSRegularExpression(pattern:"(@[a-z])\\w+", options: [])
            var found = ""
            let matches = regex.matches(in: userId, options: [], range: NSRange(location: 0, length: userId.count))
            
            if (matches.count > 0) {
                let range = matches[0].range(at: 0)
                var index = userId.index(userId.startIndex, offsetBy: range.location + range.length)
                found = String(userId[..<index])
                index = userId.index(userId.startIndex, offsetBy: range.location)
                found = String(found[index...])
                return found
            }
            
            return ""
        } catch {
            return ""
        }
    }
}

// MARK: - Content
class Content: Codable, NSCopying {
    var membership, msgtype, body: String?
    var aliases: [String]?
    var displayname: String?
    var topic, name: String?
    var alias: String?
    
    enum CodingKeys: String, CodingKey {
        case membership, msgtype, body, aliases, displayname
        case topic, name
        case alias
    }
    
    //
    // MARK: - Initializers
    init() {
        self.membership = ""
        self.msgtype = ""
        self.body = ""
        self.aliases = []
        self.displayname = ""
        self.topic = ""
        self.name = ""
        self.alias = ""
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        
        if container.contains(.membership) {
            self.membership = try container.decode(String.self, forKey: .membership)
        } else {
            self.membership = ""
        }
        
        if container.contains(.msgtype) {
            self.msgtype = try container.decode(String.self, forKey: .msgtype)
        } else {
            self.msgtype = ""
        }
        
        if container.contains(.body) {
            self.body = try container.decode(String.self, forKey: .body)
        } else {
            self.body = ""
        }
        
        if container.contains(.aliases) {
            self.aliases = try container.decode([String].self, forKey: .aliases)
        } else {
            self.aliases = []
        }
        
        if container.contains(.displayname) {
            self.displayname = try container.decode(String.self, forKey: .displayname)
        } else {
            self.displayname = ""
        }
        
        if container.contains(.topic) {
            self.topic = try container.decode(String.self, forKey: .topic)
        } else {
            self.topic = ""
        }
        
        if container.contains(.name) {
            self.name = try container.decode(String.self, forKey: .name)
        } else {
            self.name = ""
        }
        
        if container.contains(.alias) {
            self.alias = try container.decode(String.self, forKey: .alias)
        } else {
            self.alias = ""
        }
    }
    
    //
    // MARK: - NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Content()
        copy.membership = self.membership
        copy.msgtype = self.msgtype
        copy.body = self.body
        copy.aliases = self.aliases
        copy.displayname = self.displayname
        copy.topic = self.topic
        copy.name = self.name
        copy.alias = self.alias
        return copy
    }
}
