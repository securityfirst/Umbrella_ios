//
//  UmbrellaClient.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

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

class UmbrellaClient: NetworkClient {
    
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
                            print(httpResponse.statusCode)
                            
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
}
