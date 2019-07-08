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
    
    /// Upload file
    ///
    /// - Parameters:
    ///   - accessToken: String
    ///   - filename: String
    ///   - fileURL: URL
    ///   - success: Closure
    ///   - failure: Closure
    func downloadFile(filename: String, uri: String, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        client.requestDownload(router: UmbrellaMediaRouter.download(uri: uri), success: { (response) in
            
            do {
                let data = (response as? Data)!
                
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    let fileURL = documentDirectory.appendingPathComponent(filename)
                    try data.write(to: fileURL)
                    success(fileURL)
                }
            } catch {
                print("error:", error)
                failure(nil, nil, MatrixError("error", error: "error"))
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
