//
//  UmbrellaMatrixRoomService.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class UmbrellaMatrixRoomService: Service {
    
    //
    // MARK: - Properties
    fileprivate var client: NetworkClient
    
    //
    // MARK: - Init
    required init(client: NetworkClient) {
        self.client = client
    }
    
    /// Create a room on Matrix Chat
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - room: Room
    ///   - success: Closure
    ///   - failure: Closure
    func createRoom(accessToken: String, room: Room, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRoomRouter.createRoom(accessToken: accessToken, room: room), success: { (response) in
            do {
                guard let data = response as? String else {
                    print("Error cast response to String")
                    return
                }
                let room = try JSONDecoder().decode(RoomResponse.self, from: data.data(using: .utf8)!)
                success(room as AnyObject)
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        }, failure: { (response, object, error) in
            do {
                if let object = object {
                    let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                    let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                    failure(response, object, matrixError)
                } else {
                    failure(response, object, MatrixError("error", error: "error"))
                }
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
    
    /// List of Public Rooms
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - success: Closure
    ///   - failure: Closure
    func publicRooms(accessToken: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRoomRouter.publicRooms(accessToken: accessToken), success: { (response) in
            do {
                guard let data = response as? String else {
                    print("Error cast response to String")
                    return
                }
                let publicRoom = try JSONDecoder().decode(PublicRoom.self, from: data.data(using: .utf8)!)
                success(publicRoom as AnyObject)
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        }, failure: { (response, object, error) in
            do {
                if let object = object {
                    let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                    let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                    failure(response, object, matrixError)
                } else {
                    failure(response, object, MatrixError("error", error: "error"))
                }
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
    
    /// Get Message from a room on Matrix Chat
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - success: Closure
    ///   - failure: Closure
    func getMessages(accessToken: String, roomId: String, dir: String, from: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRoomRouter.getMessages(accessToken: accessToken, roomId: roomId, dir: dir, from: from), success: { (response) in
            do {
                guard let data = response as? String else {
                    print("Error cast response to String")
                    return
                }
                let chatMessage = try JSONDecoder().decode(ChatMessage.self, from: data.data(using: .utf8)!)
                
                let pagination = UserDefaults.standard.object(forKey: roomId)
                
                if pagination == nil {
                    let pag = chatMessage.start + ";" + chatMessage.end + ";" + "1"
                    UserDefaults.standard.set(pag, forKey: roomId)
                } else {
                    let pag = chatMessage.start + ";" + chatMessage.end + ";" + "2"
                    UserDefaults.standard.set(pag, forKey: roomId)
                }
                
                success(chatMessage as AnyObject)
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        }, failure: { (response, object, error) in
            do {
                
                if let object = object {
                    let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                    let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                    failure(response, object, matrixError)
                } else {
                    failure(response, object, MatrixError("error", error: "error"))
                }

            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
    
    /// Send a message from a room on Matrix Chat
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - success: Closure
    ///   - failure: Closure
    func sendMessage(accessToken: String, roomId: String, type: RoomTypeMessage, message: String, url: String = "", success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRoomRouter.sendMessage(accessToken: accessToken, roomId: roomId, type: type.self.rawValue, message: message, url: url), success: { (response) in
            success("")
        }, failure: { (response, object, error) in
            do {
                if let object = object {
                    let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                    let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                    failure(response, object, matrixError)
                } else {
                    failure(response, object, MatrixError("error", error: "error"))
                }
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
    
    /// Invite an user from a room on Matrix Chat
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - success: Closure
    ///   - failure: Closure
    func inviteAnUserToRoom(accessToken: String, roomId: String, userId: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRoomRouter.inviteUserToRoom(accessToken: accessToken, roomId: roomId, userId: userId), success: { (response) in
            success(response as AnyObject)
        }, failure: { (response, object, error) in
            do {
                if let object = object {
                    let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                    let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                    failure(response, object, matrixError)
                } else {
                    failure(response, object, MatrixError("error", error: "error"))
                }
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
    
    /// Join to a room on Matrix Chat
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - success: Closure
    ///   - failure: Closure
    func joinRoom(accessToken: String, roomId: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRoomRouter.joinRoom(accessToken: accessToken, roomId: roomId), success: { (response) in
            success(response as AnyObject)
        }, failure: { (response, object, error) in
            do {
                if let object = object {
                    let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                    let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                    failure(response, object, matrixError)
                } else {
                    failure(response, object, MatrixError("error", error: "error"))
                }
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
    
    /// Leave to a room on Matrix Chat
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - success: Closure
    ///   - failure: Closure
    func leaveRoom(accessToken: String, roomId: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRoomRouter.leaveRoom(accessToken: accessToken, roomId: roomId), success: { (response) in
            success(response as AnyObject)
        }, failure: { (response, object, error) in
            do {
                if let object = object {
                    let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                    let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                    failure(response, object, matrixError)
                } else {
                    failure(response, object, MatrixError("error", error: "error"))
                }
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
}
