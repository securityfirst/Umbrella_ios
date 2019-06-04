//
//  BaseChecklistViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 03/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class BaseChecklistViewController: UIViewController {
    
    //
    // MARK: - Properties
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    var currentViewController: UIViewController?
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    lazy var checklistViewController: ChecklistViewController! = {
        let storyboard = UIStoryboard(name: "Checklist", bundle: Bundle.main)
        let checklistViewController = (storyboard.instantiateViewController(withIdentifier: "ChecklistViewController") as? ChecklistViewController)!
        return checklistViewController
    }()
    
    lazy var customChecklistViewController : CustomChecklistViewController! = {
        let storyboard = UIStoryboard(name: "Checklist", bundle: Bundle.main)
        let customChecklistViewController = (storyboard.instantiateViewController(withIdentifier: "CustomChecklistViewController") as? CustomChecklistViewController)!
        return customChecklistViewController
    }()
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Checklists".localized()
        self.navigationItem.title = "Checklists".localized()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBarButtonItem.isEnabled = false
        self.addBarButtonItem.tintColor = self.addBarButtonItem.isEnabled ? #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1) : UIColor.clear
        self.segmentedControl.setTitle("Overview".localized(), forSegmentAt: 0)
        self.segmentedControl.setTitle("Custom".localized(), forSegmentAt: 1)
        
        displayCurrentTab(0)
    }
    
    //
    // MARK: - Functions
    
    /// Update language
    @objc func updateLanguage() {
        self.title = "Checklists".localized()
        self.navigationItem.title = "Checklists".localized()
        self.segmentedControl?.setTitle("Overview".localized(), forSegmentAt: 0)
        self.segmentedControl?.setTitle("Custom".localized(), forSegmentAt: 1)
        
    }
    
    /// Display current ViewController by tabIndex
    ///
    /// - Parameter tabIndex: Int
    func displayCurrentTab(_ tabIndex: Int) {
        if let viewController = viewControllerForSelectedIndex(tabIndex) {
            self.addChild(viewController)
            viewController.didMove(toParent: self)
            viewController.view.frame = self.contentView.bounds
            self.contentView.addSubview(viewController.view)
            self.currentViewController = viewController
        }
    }
    
    /// Select viewController
    ///
    /// - Parameter index: Int
    /// - Returns: UIViewController
    func viewControllerForSelectedIndex(_ index: Int) -> UIViewController? {
        var viewController: UIViewController?
        switch index {
        case 0 :
            viewController = self.checklistViewController
            self.addBarButtonItem.isEnabled = false
            self.addBarButtonItem.tintColor = self.addBarButtonItem.isEnabled ? #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1) : UIColor.clear
        case 1 :
            viewController = self.customChecklistViewController
            self.addBarButtonItem.isEnabled = true
            self.addBarButtonItem.tintColor = self.addBarButtonItem.isEnabled ? #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1) : UIColor.clear
        default:
            return nil
        }
        
        return viewController
    }
    
    //
    // MARK: - Actions
    
    @IBAction func changeViewAction(_ sender: UISegmentedControl) {
        self.currentViewController?.view.removeFromSuperview()
        self.currentViewController?.removeFromParent()
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    @IBAction func addAction(_ sender: Any) {
        let alertController = UIAlertController(title: "New Checklist".localized(), message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Name of Checklist".localized()
            textField.keyboardType = UIKeyboardType.alphabet
            textField.autocapitalizationType = .sentences
        }
        let saveAction = UIAlertAction(title: "Save".localized(), style: UIAlertAction.Style.default, handler: { _ in
            let firstTextField = alertController.textFields![0] as UITextField
            
            if let count = firstTextField.text?.count, count > 0 {
                self.customChecklistViewController.performSegue(withIdentifier: "newSegue", sender: firstTextField.text!)
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
