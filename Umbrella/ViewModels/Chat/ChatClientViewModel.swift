//
//  ChatClientViewModel.swift
//  Umbrella
//
//  Created by Lucas Correa on 27/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class ChatClientViewModel {
    
    var service: UmbrellaMatrixClientService
    var sqlManager: SQLManager
    var sync: Sync?
    var rooms: [Room] = [Room]()
    
    lazy var userMatrixDao: UserMatrixDao = {
        let userMatrixDao = UserMatrixDao(sqlProtocol: self.sqlManager)
        return userMatrixDao
    }()
    
    lazy var roomDao: RoomDao = {
        let roomDao = RoomDao(sqlProtocol: self.sqlManager)
        return roomDao
    }()
    
    init() {
        self.service = UmbrellaMatrixClientService(client: UmbrellaClient())
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        _ = self.userMatrixDao.createTable()
    }
    //
    // MARK: - Initializer
    init(service: UmbrellaMatrixClientService = UmbrellaMatrixClientService(client: UmbrellaClient())) {
        self.service = service
        self.sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
    }
    
    //
    // MARK: - Public Functions
    func sync(success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        let status = Reachability().connectionStatus()
        if status.description == "Offline" {
            self.rooms.removeAll()
            self.rooms = self.roomDao.list()
            self.rooms.sort(by: {$0.name < $1.name })
            success(nil)
        } else {
            
            let user = getUserLogged()
            
            if let user = user {
                service.sync(token: user.accessToken, success: { (object) in
                    self.sync = (object as? Sync)!
                    self.rooms.removeAll()
                    for dic in (self.sync?.rooms.join)! {
                        
                        let joinEvents: [JoinEvent] = dic.value.timeline.joinEvent.filter { $0.type == "m.room.name" }
                        let memberEvents: [JoinEvent] = dic.value.timeline.joinEvent.filter { $0.type == "m.room.member" }
                        let aliasEvents: [JoinEvent] = dic.value.timeline.joinEvent.filter { $0.type == "m.room.canonical_alias" }
                        
                        if aliasEvents.count > 0 {
                            var nameAlias = ""
                            for aliasEvent in aliasEvents {
                                nameAlias = self.normalizeName(identifier: "#", text: aliasEvent.content.alias ?? "")
                            }
                            
                            if nameAlias == "contact_room" {
                                if memberEvents.count == 2 {
                                    var nameInvite = ""
                                    var nameJoin = ""
                                    for joinEvent in memberEvents {
                                        
                                        if joinEvent.content.membership == "invite" {
                                            nameInvite = self.normalizeName(identifier: "@", text: joinEvent.sender)
                                        } else if joinEvent.content.membership == "join" {
                                            nameJoin = self.normalizeName(identifier: "@", text: joinEvent.sender)
                                        }
                                    }
                                    
                                    var name = ""
                                    
                                    if user.username == nameInvite {
                                        name = nameJoin
                                    } else {
                                        name = nameInvite
                                    }
                                    
                                    let room = Room(roomId: dic.key, name: name.capitalized, topic: "", canonicalAlias: nameAlias)
                                    self.rooms.append(room)
                                    _ = self.roomDao.insert(room)
                                }
                            } else {
                                for joinEvent in joinEvents {
                                    let room = Room(roomId: dic.key, name: joinEvent.content.name!, topic: "", canonicalAlias: "")
                                    self.rooms.append(room)
                                    _ = self.roomDao.insert(room)
                                }
                            }
                            
                        } else {
                            for joinEvent in joinEvents {
                                let room = Room(roomId: dic.key, name: joinEvent.content.name!, topic: "", canonicalAlias: "")
                                self.rooms.append(room)
                                _ = self.roomDao.insert(room)
                            }
                        }
                        
                    }
                    
                    self.rooms.sort(by: {$0.name < $1.name })
                    success(object as AnyObject)
                }, failure: { (response, object, error) in
                    failure(response, object, error)
                })
            }
        }
    }
    
    func removePublicRooms(publicRoomList: [Room]) {
        
        for room in publicRoomList {
            for local in self.rooms where room.roomId == local.roomId {
                self.rooms.removeObject(obj: local)
                break
            }
        }
    }
    
    func normalizeName(identifier: String, text: String) -> String {
        do {
            
            let regex = try NSRegularExpression(pattern:"(\(identifier)[a-z])\\w+", options: [])
            var found = ""
            let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
            
            if (matches.count > 0) {
                let range = matches[0].range(at: 0)
                var index = text.index(text.startIndex, offsetBy: range.location + range.length)
                found = String(text[..<index])
                index = text.index(text.startIndex, offsetBy: range.location)
                found = String(found[index...])
                return found.replacingOccurrences(of: "\(identifier)", with: "")
            }
            
            return ""
        } catch {
            return ""
        }
    }
    
    func getUserLogged() -> UserMatrix? {
        let users = userMatrixDao.list()
        return users.first
    }
    
}
