//
//  TitleFormView.swift
//  Umbrella
//
//  Created by Lucas Correa on 16/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class TitleFormView: UIView, StepperProtocol {
    
    //
    // MARK: - Properties
    var indexView: UIView?
    var titleLabel: UILabel?
    var indexLabel: UILabel?
    var viewSeparator: UIView?
    
    //
    // MARK: - StepperProtocol
    var index: Int = 0
    var stage: StepperStage = .active {
        didSet {
            switch stage {
            case .active:
                indexLabel?.text = "\(index+1)"
                indexView?.backgroundColor = #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1)
                titleLabel?.textColor = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)
                titleLabel?.font = UIFont(name: "Roboto-Bold", size: 12)
            case .done:
                indexLabel?.text = "✓"
                indexView?.backgroundColor = #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1)
                titleLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                titleLabel?.font = UIFont(name: "Roboto-Bold", size: 12)
            case .inactive:
                indexView?.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                titleLabel?.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                titleLabel?.font = UIFont(name: "Roboto-Regular", size: 12)
            }
        }
    }
    
    /// Set title and add a separator
    ///
    /// - Parameter string: Title
    func setTitle(_ string: String) {
        titleLabel?.text = string
        // Change the size according to the size of the text
        let widthOfText:CGFloat = (titleLabel?.text?.width(withConstrainedHeight: 40.0, font: (titleLabel?.font)!))!
        if widthOfText <= (titleLabel?.frame.size.width)! {
            var frame = titleLabel?.frame
            frame?.size.width = widthOfText
            titleLabel?.frame = frame!
        }
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.numberOfLines = 0
        titleLabel?.minimumScaleFactor = 0.4
        
        //Separator
        viewSeparator = UIView(frame: CGRect(x: (titleLabel?.frame.origin.x)! + (titleLabel?.frame.size.width)! + 5, y: self.frame.size.height/2, width:0, height: 1))
        
        var frame = viewSeparator?.frame
        frame?.size.width = self.frame.size.width - (viewSeparator?.frame.origin.x)! - 4
        viewSeparator?.frame = frame!
        viewSeparator?.backgroundColor = UIColor.darkGray
        addSubview(viewSeparator!)
    }
}
