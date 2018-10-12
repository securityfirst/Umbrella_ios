//
//  TitleLessonView.swift
//  SideScroll
//
//  Created by Lucas Correa on 09/10/2018.
//  Copyright © 2018 Lucas Correa. All rights reserved.
//

import UIKit

class TitleLessonView: UIView, SideScrollProtocol {
    
    //
    // MARK: - Properties
    var titleLabel: UILabel?
    
    //
    // MARK: - SideScrollProtocol
    var index: Int = 0
    var stage: SideScrollStage = .active {
        didSet {
            switch stage {
            case .active:
                titleLabel?.textColor = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)
                titleLabel?.font = UIFont(name: "SFProText-SemiBold", size: 11)
            case .inactive:
                titleLabel?.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                titleLabel?.font = UIFont(name: "SFProText-SemiBold", size: 11)
            }
        }
    }
    
    /// Set title and add a separator
    ///
    /// - Parameter string: Title
    func setTitle(_ string: String) {
        titleLabel?.text = string.uppercased()
    }
}
