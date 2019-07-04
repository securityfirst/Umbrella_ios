//
//  MediaService.swift
//  Umbrella
//
//  Created by Lucas Correa on 04/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

class MediaService: Service {
    
    //
    // MARK: - Properties
    fileprivate var client: NetworkClient
    
    //
    // MARK: - Init
    required init(client: NetworkClient) {
        self.client = client
    }
    
    /// Upload file
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - filename: String
    ///   - fileURL: URL
    ///   - success: Closure
    ///   - failure: Closure
    func uploadFile(accessToken: String, filename: String, fileURL: URL, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        
        client.requestUpload(router: UmbrellaMediaRouter.upload(accessToken: accessToken, filename: filename), fileURL: fileURL, success: { (response) in
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
