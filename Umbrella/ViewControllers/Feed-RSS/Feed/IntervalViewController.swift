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
    
    lazy var locationViewModel: LocationViewModel = {
        let locationViewModel = LocationViewModel()
        return locationViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        intervalText.setBottomBorder()
        intervalText.placeholder = "Enter interval".localized()
        intervalText.delegate = self
        intervalText.becomeFirstResponder()
        saveButton.setTitle("Save".localized(), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Actions
    @IBAction func saveAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
//        NotificationCenter.default.post(name: Notification.Name("UpdateLocation"), object: nil, userInfo: ["location": intervalText.text ?? ""])
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
        
//        if let text = textField.text,
//            let textRange = Range(range, in: text) {
//            let updatedText = text.replacingCharacters(in: textRange,
//                                                       with: string)
//
//            if updatedText.count >= 3 {
//                self.locationViewModel.geocode(of: updatedText) {
//                    self.cityTableView.reloadData()
//                }
//            } else {
//                self.locationViewModel.cityArray.removeAll()
//                self.cityTableView.reloadData()
//            }
//        }
        
        return true
    }
}
