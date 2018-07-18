//
//  StepperProtocol.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation

enum StepperStage {
    case active
    case done
    case inactive
}

protocol StepperProtocol {
    var index: Int { get set }
    var stage: StepperStage { get set }
}
