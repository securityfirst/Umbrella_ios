//
//  FillFormViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FillFormViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var fillFormViewModel: FillFormViewModel = {
        let fillFormViewModel = FillFormViewModel()
        return fillFormViewModel
    }()
    
    @IBOutlet weak var stepperView: StepperView!
    @IBOutlet weak var formScrollView: UIScrollView!
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var isNewForm: Bool = true
    var currentPage: CGFloat = 0
    var askForPasswordView: AskForPasswordView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = fillFormViewModel.form.name
        self.stepperView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if view.tag == 99 {
            return
        }
        view.tag = 99
        
        self.stepperView.updateFrame()
        self.stepperView.dataSource = self
        self.stepperView.reloadData()
        self.stepperView.isHidden = false
        self.stepperView.isAccessibilityElement = false
        self.stepperView.accessibilityElementsHidden = true
        
        var newFormAnswerId = (fillFormViewModel.formAnswerId())
        
        // If is a new form
        // We need to add one more to be a new form answer.
        if isNewForm {
            newFormAnswerId += 1
        }
      
        var formAnswers: [FormAnswer] = []
        if let screen = fillFormViewModel.form.screens.first {
            formAnswers = fillFormViewModel.loadFormAnswersTo(formId: screen.formId)
        }
        
        for (index,item) in fillFormViewModel.form.screens.enumerated() {
            var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            frame.origin.x = self.formScrollView.frame.size.width * CGFloat(index)
            frame.size = self.formScrollView.frame.size
            
            let storyboard = UIStoryboard(name: "Form", bundle: Bundle.main)
            let viewController = storyboard.instantiateViewController(withIdentifier: "DynamicViewController")
            let subView = (viewController.view as? DynamicFormView)!
            subView.frame = frame
            subView.tag = index
            subView.dynamicFormViewModel.screen = item
            subView.dynamicFormViewModel.formAnswers = formAnswers
            subView.setTitle(title: subView.dynamicFormViewModel.screen.name)
            subView.titleLabel.accessibilityTraits = UIAccessibilityTraits.staticText
            subView.titleLabel.accessibilityHint = String(format: "This is form %d of %d forms to fill out. Swipe three fingers on left to next or right back form.".localized(), index+1, fillFormViewModel.form.screens.count)
            
            if isNewForm {
                subView.dynamicFormViewModel.newFormAnswerId = newFormAnswerId
            } else {
                subView.dynamicFormViewModel.formAnswerId = Int64(fillFormViewModel.formAnswer.formAnswerId)
            }
            
            self.formScrollView.addSubview(subView)
            
            // Simple Animation
            subView.alpha = 0
            UIView.animate(withDuration: 0.4) {
                subView.alpha = 1
                self.progressIndicatorView.isHidden = true
                self.progressIndicatorView.isAccessibilityElement = false
            }
        }
        
        self.formScrollView.contentSize = CGSize(width: self.formScrollView.frame.size.width * CGFloat(fillFormViewModel.form.screens.count), height: self.formScrollView.frame.size.height)
        
        checkPassword()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParent {
            self.saveForm()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Check password
    func checkPassword() {
        
        let passwordCustom: Bool = UserDefaults.standard.object(forKey: "passwordCustom") as? Bool ?? false
        let skipPassword: Bool = UserDefaults.standard.object(forKey: "skipPassword") as? Bool ?? false
        
        if passwordCustom || skipPassword {
            return
        }
        
        self.askForPasswordView = (Bundle.main.loadNibNamed("AskForPasswordView", owner: self, options: nil)![0] as? AskForPasswordView)!
        self.askForPasswordView.show(view: self.view)
        
        self.askForPasswordView.save { (password, confirm) in
            
            if password.count > 0 && confirm.count > 0 &&
                self.validatePassword(password: password, confirm: confirm) {
                let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
                
                var oldPassword = ""
                let passwordCustom: Bool = UserDefaults.standard.object(forKey: "passwordCustom") as? Bool ?? false
                if passwordCustom {
                    oldPassword = CustomPassword.shared.password
                } else {
                    oldPassword = Database.password
                }
                
                sqlManager.changePassword(oldPassword: oldPassword, newPassword: password)
                CustomPassword.shared.password = password
                self.askForPasswordView.close()
            }
        }
        
        self.askForPasswordView.skip {
            let alertController = UIAlertController(title: "Skip setting password".localized(), message: "Are you sure you want to continue using the app without setting the password? \n\nThis significantly diminishes your safely in regards with any identifiable data you input into Umbrella.".localized(), preferredStyle: UIAlertController.Style.alert)
            let saveAction = UIAlertAction(title: "YES".localized(), style: UIAlertAction.Style.default, handler: { (action) in
                UserDefaults.standard.set(true, forKey: "skipPassword")
                UserDefaults.standard.synchronize()
            })
            
            let cancelAction = UIAlertAction(title: "NO".localized(), style: UIAlertAction.Style.cancel, handler: { (action) in
                
            })
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    /// Validate if there is an url valid
    ///
    /// - Parameter urlString: String
    /// - Returns: Bool
    func validatePassword(password: String, confirm: String) -> Bool {
        
        var check = true
        var message = ""
        
        if !password.contains(confirm) {
            check = false
            message = "Passwords do not match.".localized()
        } else if password.count < 8 {
            check = false
            message = "Password too short.".localized()
        } else if !NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: password) || !NSPredicate(format: "SELF MATCHES %@", ".*[0-9]+.*").evaluate(with: confirm) {
            check = false
            message = "Password must have at least one digit.".localized()
        } else if !NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: password) || !NSPredicate(format: "SELF MATCHES %@", ".*[A-Z]+.*").evaluate(with: confirm) {
            check = false
            message = "Password must have at least one capital letter.".localized()
        }
        
        if !check {
            UIApplication.shared.keyWindow!.makeToast(message, duration: 3.0, position: .top)
        }
        
        return check
    }
    
    /// Save form
    func saveForm() {
        for viewForm in self.formScrollView.subviews where viewForm is DynamicFormView {
            let view = (viewForm as? DynamicFormView)!
            DispatchQueue.main.async {
                view.saveForm()
            }
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func backAction(_ sender: Any) {
        self.formScrollView.contentOffset.x = (currentPage - 1) * self.formScrollView.frame.size.width
    }
    
    @IBAction func nextAction(_ sender: Any) {
        self.formScrollView.contentOffset.x = (currentPage + 1) * self.formScrollView.frame.size.width
    }
}

//
// MARK: - UIScrollViewDelegate
extension FillFormViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateDidScroll(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateDidScroll(scrollView)
    }
    
    func updateDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        currentPage = pageNumber
        stepperView.scrollViewDidPage(page: currentPage)
        self.view.endEditing(true)
        self.backButton.isHidden = (currentPage == 0)
        
        if (Int(currentPage) == fillFormViewModel.form.screens.count - 1) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}

//
// MARK: - StepperViewDataSource
extension FillFormViewController: StepperViewDataSource {
    
    func viewAtIndex(_ index: Int) -> UIView {
        
        //ViewMain
        let titleFormView = TitleFormView(frame: CGRect(x: CGFloat(index) * self.stepperView.visivelPercentualSize, y: 2, width: self.stepperView.viewWidth(index: index), height: self.stepperView.frame.size.height-5))
        
        // View of the Index
        titleFormView.indexView = UIView(frame: CGRect(x: 10, y: self.stepperView.frame.size.height/2-20/2, width: 20, height: 20))
        titleFormView.indexView?.backgroundColor = #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1)
        titleFormView.indexView?.layer.cornerRadius = (titleFormView.indexView?.frame.size.height)!/2
        titleFormView.addSubview(titleFormView.indexView!)
        titleFormView.indexLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (titleFormView.indexView?.frame.size.width)!, height: (titleFormView.indexView?.frame.size.height)!))
        
        titleFormView.indexLabel?.font = UIFont(name: "Roboto-Regular", size: 10)
        titleFormView.indexLabel?.textColor = UIColor.white
        titleFormView.indexLabel?.textAlignment = .center
        titleFormView.indexView?.addSubview(titleFormView.indexLabel!)
        
        titleFormView.indexLabel?.text = "\(index+1)"
        
        //Title
        titleFormView.titleLabel = UILabel(frame: CGRect(x: (titleFormView.indexView?.frame.origin.x)! + (titleFormView.indexView?.frame.size.width)! + 5, y: self.stepperView.frame.size.height/2-20/2, width: titleFormView.frame.size.width - ((titleFormView.indexView?.frame.origin.x)! + (titleFormView.indexView?.frame.size.width)! + 50), height: 20))
        titleFormView.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 12)
        titleFormView.addSubview(titleFormView.titleLabel!)
        
        titleFormView.setTitle(fillFormViewModel.form.screens[index].name)
        
        return titleFormView
    }
    
    func numberOfTitles() -> Int {
        return fillFormViewModel.form.screens.count
    }
}
