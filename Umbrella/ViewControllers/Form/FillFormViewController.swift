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
    
    var isNewForm: Bool = true
    var pageCurrent: CGFloat = 0
    @IBOutlet weak var stepperView: StepperView!
    @IBOutlet weak var formScrollView: UIScrollView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = fillFormViewModel.form.name
        
        self.stepperView.dataSource = self
        self.stepperView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
            }
        }
        
        self.formScrollView.contentSize = CGSize(width: self.formScrollView.frame.size.width * CGFloat(fillFormViewModel.form.screens.count), height: self.formScrollView.frame.size.height)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController {
            self.saveForm()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Save form
    func saveForm() {
        for viewForm in self.formScrollView.subviews where viewForm is DynamicFormView {
            let view = (viewForm as? DynamicFormView)!
            DispatchQueue.main.async {
                view.saveForm()
            }
        }
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
        pageCurrent = pageNumber
        stepperView.scrollViewDidPage(page: pageCurrent)
        self.view.endEditing(true)
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
