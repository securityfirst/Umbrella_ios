//
//  Global.swift
//  Umbrella
//
//  Created by Lucas Correa on 20/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit

class Global {
    internal static var dateFormatter: DateFormatter = DateFormatter()
}

//
// MARK: - Function

/// Execute a function in a closure with a interval
///
/// - Parameters:
///   - delay: interval
///   - closure: closure
func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
