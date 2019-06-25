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
                let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                failure(response, object, matrixError)
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
    
    /// Create a room on Matrix Chat
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - room: Room
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
                let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                failure(response, object, matrixError)
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
}
