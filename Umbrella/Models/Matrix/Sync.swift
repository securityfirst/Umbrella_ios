//
//  Sync.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

// MARK: - Sync
struct Sync: Codable {
    let rooms: Rooms
    
    enum CodingKeys: String, CodingKey {
        case rooms
    }
}

// MARK: - Rooms
struct Rooms: Codable {
    let invite: [String: Invite]
    let join: [String: Join]
}

// MARK: - Invite
struct Join: Codable {
    let timeline: Timeline
    
    enum CodingKeys: String, CodingKey {
        case timeline
    }
}

struct Timeline: Codable {
    let joinEvent: [JoinEvent]
    
    enum CodingKeys: String, CodingKey {
        case joinEvent = "events"
    }
}

struct JoinEvent: Codable {
    let type: String
    let eventID: String
    let originServerTs: Int
    let content: JoinEventContent
    
    enum CodingKeys: String, CodingKey {
        case type
        case eventID = "event_id"
        case originServerTs = "origin_server_ts"
        case content
    }
}

// MARK: - TentacledContent
struct JoinEventContent: Codable {
    let alias, joinRule, name, membership: String?
    let displayname: String?
    
    enum CodingKeys: String, CodingKey {
        case alias
        case joinRule = "join_rule"
        case name, membership, displayname
    }
}

// MARK: - Invite
struct Invite: Codable {
    let inviteState: InviteState
    
    enum CodingKeys: String, CodingKey {
        case inviteState = "invite_state"
    }
}

// MARK: - InviteState
struct InviteState: Codable {
    let events: [InviteStateEvent]
}

// MARK: - InviteStateEvent
struct InviteStateEvent: Codable {
    let type: String
    let content: TentacledContent
    let sender: String
    let originServerTs: Int?
    
    enum CodingKeys: String, CodingKey {
        case type
        case content
        case sender
        case originServerTs = "origin_server_ts"
    }
}

// MARK: - TentacledContent
struct TentacledContent: Codable {
    let alias, joinRule, name, membership: String?
    let displayname: String?
    
    enum CodingKeys: String, CodingKey {
        case alias
        case joinRule = "join_rule"
        case name, membership, displayname
    }
}
