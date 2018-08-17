//
//  ChoiceButton.swift
//  Umbrella
//
//  Created by Lucas Correa on 30/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

enum ChoiceType {
    case multi
    case single
    case none
}

class ChoiceButton: UIView {
 
    //
    // MARK: - Properties
    var imageView: UIImageView!
    var button: UIButton!
    var index: Int = 0
    var choiceType: ChoiceType = .none
    var state: Bool = false
    var completionHandler: ((_ index: Int) -> Void)?
    fileprivate var title: String = ""
    
    //
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        imageView = UIImageView(frame: CGRect(x: 2, y: 5, width: 20, height: 20))
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        button = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width - 5, height: 30))
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 12)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleEdgeInsets.left = 30
        button.addTarget(self, action: #selector(changeAction), for: .touchUpInside)
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // MARK: - Functions
    
    func setTitle(_ title: String) {
        self.title = title
        button.setTitle(title, for: .normal)
    }
    
    /// Set new state to the component check or group
    ///
    /// - Parameter state: Bool
    func setState(state: Bool) {
        self.state = state
        button.accessibilityLabel = state ? "\(title) \("selected".localized())" : "\(title) \("deselected".localized())"
        
        switch choiceType {
        case .multi:
            imageView.image = UIImage(named: state == true ? "checkSelected" : "checkNormal")
        case .single:
            imageView.image = UIImage(named: state == true ? "groupSelected" : "groupNormal")
        case .none:
            imageView.image = UIImage(named: state == true ? "" : "")
        }
    }
    
    /// Change state with closure
    ///
    /// - Parameter closure: Block
    func changeState(closure: @escaping (_ index: Int) -> Void) {
        completionHandler = closure
    }
    
    /// Action to change the state
    @objc func changeAction() {
        self.state = !self.state
        setState(state: self.state)
        completionHandler?(index)
    }
}
