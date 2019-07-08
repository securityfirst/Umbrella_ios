//
//  NetworkClient.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/06/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import Foundation

protocol NetworkClient {
    func request(router: Router, success: @escaping SuccessHandler, failure: @escaping FailureHandler)
    func requestUpload(router: Router, fileURL: URL, success: @escaping SuccessHandler, failure: @escaping FailureHandler)
    func requestDownload(router: Router, success: @escaping SuccessHandler, failure: @escaping FailureHandler)
}
