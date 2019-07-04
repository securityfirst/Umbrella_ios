//
//  UmbrellaClient.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

struct MatrixError: Error {
    let errorCode: String
    let error: String
    
    init(_ errorCode: String, error: String) {
        self.errorCode = errorCode
        self.error = error
    }
    
    public var localizedDescription: String {
        return errorCode + " " + error
    }
}

public typealias SuccessHandler = (Any?) -> Void
public typealias FailureHandler = (URLResponse?, Any?, Error?) -> Void

class UmbrellaClient: NSObject, NetworkClient {
    
    func request(router: Router, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        var urlRequest = URLRequest(url: router.url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        urlRequest.httpMethod = router.method
        
        for (key, value) in router.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = router.parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if (error != nil) {
                failure(response, data, error)
            } else {
                if let json = data {
                    DispatchQueue.main.async {
                        let string = String(data: json, encoding: String.Encoding.utf8)
                        
                        if let httpResponse = response as? HTTPURLResponse {
                            if httpResponse.statusCode == 200 {
                                success(string ?? "")
                            } else {
                                failure(response, data, error)
                            }
                        }
                    }
                }
                
            }
            }.resume()
    }
    
    func requestUpload(router: Router, fileURL: URL, success: @escaping SuccessHandler, failure: @escaping FailureHandler) {
        var urlRequest = URLRequest(url: router.url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        urlRequest.httpMethod = router.method
        
        for (key, value) in router.headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = router.parameters {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.isDiscretionary = false
        sessionConfig.networkServiceType = .video
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue.main)
        
        let task = session.uploadTask(with: urlRequest, fromFile: fileURL) { (data, response, error) in
            
            if (error != nil) {
                failure(response, data, error)
            } else {
                if let data = data {
                    DispatchQueue.main.async {
                        
                        if let httpResponse = response as? HTTPURLResponse {
                            if httpResponse.statusCode == 200 {
//                                {"content_uri":"mxc://comms.secfirst.org/bnLRvVAUhvACyUgWHwTrBuDC"}
                                
                                let json: [String: String] = try! JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : String]
                                
                                success(json["content_uri"] ?? "")
                            } else {
                                failure(response, data, error)
                            }
                        }
                    }
                }
            }
        }
        task.resume()
    }
}

extension UmbrellaClient: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        let uploadProgress:Float = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
        print(uploadProgress)
    }
}
