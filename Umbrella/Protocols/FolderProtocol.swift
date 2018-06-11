//
//  FolderProtocol.swift
//  Umbrella
//
//  Created by Lucas Correa on 11/06/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

protocol FolderProtocol {
    var folderName: String? { get set }
    var categories: [Category] { get set }
}
