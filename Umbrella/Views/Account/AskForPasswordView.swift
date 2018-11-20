//
//  AskForPasswordView.swift
//  Umbrella
//
//  Created by Lucas Correa on 18/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class AskForPasswordView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmText: UITextField!
    var background: UIView = UIView(frame: (UIApplication.shared.keyWindow?.bounds)!)
    var savedCompletionHandler: ((String, String) -> Void)?
    var skipCompletionHandler: (() -> Void)?
    
    func show(view: UIView) {
        
        background.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.center = CGPoint(x: background.frame.size.width  / 2,
                              y: background.frame.size.height / 2 - 100)
        
        background.addSubview(self)
        UIApplication.shared.keyWindow!.addSubview(background)
        passwordText.becomeFirstResponder()
    }
    
    func save(saveCompletion: @escaping (String, String) -> Void) {
        self.savedCompletionHandler = saveCompletion
    }
    
    func skip(skipCompletion: @escaping () -> Void) {
        self.skipCompletionHandler = skipCompletion
    }
    
    func close() {
        background.removeFromSuperview()
    }

    @IBAction func skipAction(_ sender: Any) {
        background.removeFromSuperview()
        self.skipCompletionHandler?()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        background.removeFromSuperview()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        self.savedCompletionHandler?(passwordText.text!, confirmText.text!)
    }
    
}
