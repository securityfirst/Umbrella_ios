//
//  UmbrellaMatrixClientService.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class UmbrellaMatrixClientService: Service {
    
    //
    // MARK: - Properties
    fileprivate var client: NetworkClient
    
    //
    // MARK: - Init
    required init(client: NetworkClient) {
        self.client = client
    }
    
    /// Login an user on Matrix Chat
    ///
    /// - Parameters:
    ///   - username: String
    ///   - password: String
    ///   - type: String
    ///   - success: Closure
    ///   - failure: Closure
    func login(username: String, password: String, type: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaClientRouter.login(username: username, password: password, type: type), success: { (response) in
            do {
                guard let data = response as? String else {
                    print("Error cast response to String")
                    return
                }
                let userMatrix = try JSONDecoder().decode(UserMatrix.self, from: data.data(using: .utf8)!)
                success(userMatrix as AnyObject)
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
    
    /// Logout an user on Matrix Chat
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - success: Closure
    ///   - failure: Closure
    func logout(accessToken: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {

        client.request(router: UmbrellaClientRouter.logout(accessToken: accessToken), success: { (response) in
            success("" as AnyObject)
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
    
    /// Create an user
    ///
    /// - Parameters:
    ///   - username: String
    ///   - password: String
    ///   - email: String
    ///   - success: Closure
    ///   - failure: Closure
    func createUser(username: String, password: String, email: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaClientRouter.createUser(username: username, password: password, email: email), success: { (response) in
            do {
                guard let data = response as? String else {
                    print("Error cast response to String")
                    return
                }
                let userMatrix = try JSONDecoder().decode(UserMatrix.self, from: data.data(using: .utf8)!)
                success(userMatrix as AnyObject)
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
    
    /// Update profile from an user with email
    ///
    /// - Parameters:
    ///   - token: String
    ///   - email: String
    ///   - success: Closure
    ///   - failure: Closure
    func requestEmailToken(token: String, email: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaClientRouter.requestEmailToken(token: token, email: email), success: { (response) in
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
    
    /// Sync
    ///
    /// - Parameters:
    ///   - token: String
    ///   - success: Closure
    ///   - failure: Closure
    func sync(token: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaClientRouter.sync(token: token), success: { (response) in
            do {
                guard let data = response as? String else {
                    print("Error cast response to String")
                    return
                }
                let sync = try JSONDecoder().decode(Sync.self, from: data.data(using: .utf8)!)
                success(sync as AnyObject)
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
                    failure(response, object, MatrixError("error", error: error!.localizedDescription))
                }
            } catch let error {
                print(error)
                failure(nil, nil, error)
            }
        })
    }
    
    /// Search user
    ///
    /// - Parameters:
    ///   - token: String
    ///   - success: Closure
    ///   - failure: Closure
    func searchUser(token: String, text: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaClientRouter.searchUser(token: token, searchText: text), success: { (response) in
            do {
                guard let data = response as? String else {
                    print("Error cast response to String")
                    return
                }
                let searchUsers = try JSONDecoder().decode(SearchUser.self, from: data.data(using: .utf8)!)
                success(searchUsers as AnyObject)
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
}
