//
//  FormViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Localize_Swift
import WebKit

class FormViewController: UIViewController {
    
    //
    // MARK: - Properties
    @IBOutlet weak var formTableView: UITableView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    lazy var formViewModel: FormViewModel = {
        let formViewModel = FormViewModel()
        return formViewModel
    }()
    var isLoadingContent: Bool = false
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Forms".localized()
        
        NotificationCenter.default.addObserver(self, selector: #selector(FormViewController.loadForms(notification:)), name: Notification.Name("UmbrellaTent"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FormViewController.updateForms(notification:)), name: Notification.Name("UpdateForms"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIApplication.shared.keyWindow?.traitCollection.forceTouchCapability == UIForceTouchCapability.available {
            registerForPreviewing(with: self, sourceView: view)
        }
        self.loadingActivity.isHidden = false
        self.formTableView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // If user fill any form this function will update the umbrella.formAnswers
        self.loadFormActive()
        self.formTableView.reloadData()
        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: self.navigationItem.title)
        
        if self.isLoadingContent {
            self.loadingActivity.isHidden = true
            self.formTableView.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //
    // MARK: - Functions
    
    @objc func updateLanguage() {
        self.title = "Forms".localized()
        self.navigationController?.popViewController(animated: true)
        self.formTableView?.reloadData()
    }
    
    /// Receive the forms by notification
    ///
    /// - Parameter notification: notification with forms
    @objc func updateForms(notification: Notification) {
        self.formTableView.scrollToBottomRow()
    }
    
    /// Receive the forms by notification
    ///
    /// - Parameter notification: notification with forms
    @objc func loadForms(notification: Notification) {
        let umbrella = notification.object as? Umbrella
        self.formViewModel.umbrella = umbrella!
        
        self.isLoadingContent = true
        if let loadingActivity = self.loadingActivity {
            loadingActivity.isHidden = true
        }
        
        if let tableView = self.formTableView {
            tableView.isHidden = false
            tableView.reloadData()
        }
    }
    
    /// Load all form filled
    func loadFormActive() {
        self.formViewModel.loadFormActive()
    }
    
    /// Add the text tag html on string
    ///
    /// - Parameters:
    ///   - item: ItemForm
    ///   - html: String
    ///   - formAnswers: Array of FormAnswer
    fileprivate func htmlAddTextInput(_ item: ItemForm, _ html: inout String, _ formAnswers: [FormAnswer]) {
        var text = ""
        for formAnswer in formAnswers where formAnswer.itemFormId == item.id {
            text = formAnswer.text
        }
        html += "<input type=\"text\" value=\"\(text)\" readonly /> \n"
    }
    
    /// Add the textarea tag html on string
    ///
    /// - Parameters:
    ///   - item: ItemForm
    ///   - html: String
    ///   - formAnswers: Array of FormAnswer
    fileprivate func htmlAddTextArea(_ item: ItemForm, _ html: inout String, _ formAnswers: [FormAnswer]) {
        var text = ""
        for formAnswer in formAnswers where formAnswer.itemFormId == item.id {
            text = formAnswer.text
        }
        html += "<textarea rows=\"4\" cols=\"50\" readonly>\(text)</textarea> \n"
    }
    
    /// Add the checkbox tag html on string
    ///
    /// - Parameters:
    ///   - item: ItemForm
    ///   - html: String
    ///   - formAnswers: Array of FormAnswer
    fileprivate func htmlAddMultiChoice(_ item: ItemForm, _ html: inout String, _ formAnswers: [FormAnswer]) {
        for optionItem in item.options {
            var boolean = false
            for formAnswer in formAnswers where formAnswer.itemFormId == item.id && formAnswer.optionItemId == optionItem.id {
                boolean = true
            }
            html += "<label><input type=\"checkbox\"\(boolean ? "checked" : "") readonly onclick=\"return false;\">\(optionItem.label)</label><br> \n"
        }
    }
    
    /// Add the radio tag html on string
    ///
    /// - Parameters:
    ///   - item: ItemForm
    ///   - html: String
    ///   - formAnswers: Array of FormAnswer
    fileprivate func htmlAddSingleChoice(_ item: ItemForm, _ html: inout String, _ formAnswers: [FormAnswer]) {
        for optionItem in item.options {
            var boolean = false
            for formAnswer in formAnswers where formAnswer.itemFormId == item.id && formAnswer.optionItemId == optionItem.id {
                boolean = true
            }
            html += "<label><input type=\"radio\"\(boolean ? "checked" : "") readonly onclick=\"return false;\">\(optionItem.label)</label><br> \n"
        }
    }
    
    /// Prepare the File.html to be share
    ///
    /// - Parameters:
    ///   - indexPath: IndexPath
    /// - Returns: String
    func prepareHtml(indexPath: IndexPath) -> (nameFile: String, content: String) {
        let formAnswer = self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage()[indexPath.row]
        
        var form = Form()
        for formResult in self.formViewModel.umbrella.loadFormByCurrentLanguage() where formAnswer.formId == formResult.id {
            form = formResult
        }
        
        let formAnswers = self.formViewModel.loadFormAnswersTo(formAnswerId: formAnswer.formAnswerId, formId: form.id)
        
        var html: String = ""
        
        html += """
        <html>
        <head>
        <meta charset="UTF-8"> \n
        """
        html += "<title>\(form.name)</title> \n"
        html += "</head> \n"
        html += "<body style=\"display:block;width:100%;\"> \n"
        html += "<h1>\(form.name)</h1> \n"
        
        for screen in form.screens {
            html += "<h3>\(screen.name)</h3> \n"
            html += "<form> \n"
            
            for item in screen.items {
                html += "<p></p> \n"
                html += "<h5>\(item.name)</h5> \n"
                
                switch item.formType {
                    
                case .textInput:
                    htmlAddTextInput(item, &html, formAnswers)
                case .textArea:
                    htmlAddTextArea(item, &html, formAnswers)
                case .multiChoice:
                    htmlAddMultiChoice(item, &html, formAnswers)
                case .singleChoice:
                    htmlAddSingleChoice(item, &html, formAnswers)
                case .label:
                    break
                case .none:
                    break
                }
            }
        }
        
        html += """
        </form>
        </body>
        </html>
        """
        return (form.name.replacingOccurrences(of: " ", with: "_"), html)
    }
    
    //
    // MARK: - UIStoryboardSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fillFormSegue" {
            let fillFormViewController = (segue.destination as? FillFormViewController)!
            
            if let dic = sender as? [String: Any] {
                fillFormViewController.fillFormViewModel.form = (dic["form"] as? Form)!
                fillFormViewController.fillFormViewModel.formAnswer = (dic["formAnswer"] as? FormAnswer)!
                fillFormViewController.isNewForm = false
            }
            if let form = sender as? Form {
                fillFormViewController.fillFormViewModel.form = form
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FormViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage().count > 0 {
            return 2
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage().count > 0 {
            if section == 0 {
                return self.formViewModel.umbrella.loadFormByCurrentLanguage().count
            } else if section == 1 {
                return self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage().count
            }
        }
        
        return self.formViewModel.umbrella.loadFormByCurrentLanguage().count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FormCell = (tableView.dequeueReusableCell(withIdentifier: "FormCell", for: indexPath) as? FormCell)!
        cell.configure(withViewModel: formViewModel, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FormViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage().count > 0 {
            if indexPath.section == 0 {
                return 106.0
            } else if indexPath.section == 1 {
                return 140.0
            }
        }
        
        return 106.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 30))
        label.font = UIFont.init(name: "SFProText-SemiBold", size: 12)
        label.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        
        if self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage().count > 0 {
            if section == 0 {
                label.text = "Available forms".localized()
            } else if section == 1 {
                label.text = "Active".localized()
            }
        } else {
            label.text = "Available forms".localized()
        }
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            // Available Forms
            let form = self.formViewModel.umbrella.loadFormByCurrentLanguage()[indexPath.row]
            self.performSegue(withIdentifier: "fillFormSegue", sender: form)
        }
    }
}

//
// MARK: - FormCellDelegate
extension FormViewController: FormCellDelegate {
    
    func removeAction(indexPath: IndexPath) {
        UIAlertController.alert(title: "Alert".localized(), message: "Do you really want to remove this form?".localized(), cancelButtonTitle: "No".localized(), otherButtons: ["Yes".localized()], dismiss: { _ in
            let formAnswer:FormAnswer = self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage()[indexPath.row]
            self.formViewModel.umbrella.formAnswers.removeObject(obj: formAnswer)
            self.formViewModel.remove(formAnswerId: formAnswer.formAnswerId)
            self.formTableView.reloadData()
        }, cancel: {
            print("cancelClicked")
        })
    }
    
    func editAction(indexPath: IndexPath) {
        // Active
        let formAnswer = self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage()[indexPath.row]
        
        for form in self.formViewModel.umbrella.loadFormByCurrentLanguage() where formAnswer.formId == form.id {
            self.performSegue(withIdentifier: "fillFormSegue", sender: ["form": form, "formAnswer": formAnswer])
        }
    }
    
    func shareAction(indexPath: IndexPath) {
        
        UIAlertController.alertSheet(title: "", message: "Choose the format.".localized(), buttons: ["HTML", "PDF"], dismiss: { (option) in
            
            let shareItem = self.prepareHtml(indexPath: indexPath)
            var objectsToShare: [Any] = [Any]()
            
            if option == 0 {
                // HTML
                let html = HTML(nameFile: shareItem.nameFile + ".html", content: shareItem.content)
                let export = Export(html)
                let url = export.makeExport()
                objectsToShare = [url]
            } else if option == 1 {
                //PDF
                let pdf = PDF(nameFile: shareItem.nameFile + ".pdf", content: shareItem.content)
                let export = Export(pdf)
                let url = export.makeExport()
                objectsToShare = [url]
            }
            
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.copyToPasteboard]
            
            activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                if !completed {
                    // User canceled
                    return
                }
            }
            
            self.present(activityVC, animated: true, completion: nil)
        }, cancel: {
            print("cancel")
        })
    }
}

extension FormViewController: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: "Form", bundle: Bundle.main)
        let fillFormViewController = (storyboard.instantiateViewController(withIdentifier: "FillFormViewController") as? FillFormViewController)!
        
        let cellPosition = self.formTableView.convert(location, from: self.view)
        
        if let indexPath = self.formTableView.indexPathForRow(at: cellPosition) {
            if self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage().count > 0 {
                if indexPath.section == 0 {
                    let form = self.formViewModel.umbrella.loadFormByCurrentLanguage()[indexPath.row]
                    fillFormViewController.fillFormViewModel.form = form
                } else if indexPath.section == 1 {
                    // Active
                    let formAnswer = self.formViewModel.umbrella.loadFormAnswersByCurrentLanguage()[indexPath.row]
                    
                    for form in self.formViewModel.umbrella.loadFormByCurrentLanguage() where formAnswer.formId == form.id {
                        fillFormViewController.fillFormViewModel.form = form
                        fillFormViewController.fillFormViewModel.formAnswer = formAnswer
                        fillFormViewController.isNewForm = false
                    }
                }
            } else {
                let form = self.formViewModel.umbrella.loadFormByCurrentLanguage()[indexPath.row]
                fillFormViewController.fillFormViewModel.form = form
            }
        }
        
        fillFormViewController.preferredContentSize = CGSize(width: 0.0, height: 500)
        return fillFormViewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}
