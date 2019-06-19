//
//  UmbrellaMatrixUserService.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class UmbrellaMatrixUserService: Service {
    
    var client: NetworkClient
    
    required init(client: NetworkClient) {
        self.client = client
    }
    
    func login(username: String, password: String, type: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRouter.login(username: username, password: password, type: type), success: { (response) in
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
    
    func logout(accessToken: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {

        client.request(router: UmbrellaRouter.logout(accessToken: accessToken), success: { (response) in
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
    
    func createUser(username: String, password: String, email: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRouter.createUser(username: username, password: password, email: email), success: { (response) in
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
    
    func requestEmailToken(token: String, email: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.request(router: UmbrellaRouter.requestEmailToken(token: token, email: email), success: { (response) in
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
