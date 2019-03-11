//
//  IntervalViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class IntervalViewController: UIViewController {

    //
    // MARK: - Properties
    @IBOutlet weak var intervalText: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var spaceBottomConstraint: NSLayoutConstraint!
    lazy var locationViewModel: LocationViewModel = {
        let locationViewModel = LocationViewModel()
        return locationViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Interval".localized()
        intervalText.setBottomBorder()
        intervalText.placeholder = "Enter interval".localized()
        intervalText.delegate = self
        intervalText.becomeFirstResponder()
        saveButton.setTitle("Save".localized(), for: .normal)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Keyboard notification when change the frame
    ///
    /// - Parameter notification: NSNotification
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.spaceBottomConstraint?.constant = 25.0
                UIView.animate(withDuration: duration,
                               delay: 0,
                               options: animationCurve,
                               animations: { self.view.layoutIfNeeded() },
                               completion: nil)
            } else {
                self.spaceBottomConstraint?.constant = (endFrame?.size.height)! - 40
            }
        }
    }
    
    //
    // MARK: - Actions
    @IBAction func saveAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
        NotificationCenter.default.post(name: Notification.Name("UpdateInterval"), object: nil, userInfo: ["interval": self.intervalText.text ?? ""])
        
        UserDefaults.standard.set(self.intervalText.text ?? "", forKey: "Interval")
    }

}

//
// MARK: - UITextFieldDelegate
extension IntervalViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        intervalText.layer.shadowColor = #colorLiteral(red: 0.262745098, green: 0.6274509804, blue: 0.7921568627, alpha: 1).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        intervalText.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}
