//
//  SideScrollProtocol.swift
//  SideScroll
//
//  Created by Lucas Correa on 10/10/2018.
//  Copyright © 2018 Lucas Correa. All rights reserved.
//

import Foundation

enum SideScrollStage {
    case active
    case inactive
}

protocol SideScrollProtocol {
    var index: Int { get set }
    var stage: SideScrollStage { get set }
}
