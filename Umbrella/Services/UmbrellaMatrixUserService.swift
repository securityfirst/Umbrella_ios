//
//  UmbrellaMatrixUserService.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class UmbrellaMatrixUserService: Service {
    
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
        
        client.request(router: UmbrellaUserRouter.login(username: username, password: password, type: type), success: { (response) in
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
                let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                failure(response, object, matrixError)
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

        client.request(router: UmbrellaUserRouter.logout(accessToken: accessToken), success: { (response) in
            success("" as AnyObject)
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
    
    /// Create an user
    ///
    /// - Parameters:
    ///   - username: String
    ///   - password: String
    ///   - email: String
    ///   - success: Closure
    ///   - failure: Closure
    func createUser(username: String, password: String, email: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaUserRouter.createUser(username: username, password: password, email: email), success: { (response) in
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
                let json = try (JSONSerialization.jsonObject(with: (object as? Data)!, options: .allowFragments) as? [String:Any])!
                let matrixError = MatrixError((json["errcode"] as? String)!, error: (json["error"] as? String)!)
                failure(response, object, matrixError)
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
        
        client.request(router: UmbrellaUserRouter.requestEmailToken(token: token, email: email), success: { (response) in
                success("")
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
