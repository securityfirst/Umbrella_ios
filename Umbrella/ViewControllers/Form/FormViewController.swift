//
//  FormViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    //
    // MARK: - Properties
    @IBOutlet weak var formTableView: UITableView!
    
    lazy var formViewModel: FormViewModel = {
        let formViewModel = FormViewModel()
        return formViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(self, selector: #selector(FormViewController.loadForms(notification:)), name: Notification.Name("UmbrellaTent"), object: nil)
        
        self.title = "Form".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // If user fill any form this function will update the umbrella.formAnswers
        self.loadFormActive()
        self.formTableView.reloadData()
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.navigationItem.title)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //
    // MARK: - Functions
    
    /// Receive the forms by notification
    ///
    /// - Parameter notification: notification with forms
    @objc func loadForms(notification: Notification) {
        let umbrella = notification.object as? Umbrella
        self.formViewModel.umbrella = umbrella!
        
        if let tableView = self.formTableView {
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
            html += "<label><input type=\"checkbox\"\(boolean == true ? "checked" : "") readonly onclick=\"return false;\">\(optionItem.label)</label><br> \n"
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
            html += "<label><input type=\"radio\"\(boolean == true ? "checked" : "") readonly onclick=\"return false;\">\(optionItem.label)</label><br> \n"
        }
    }
    
    /// Prepare the File.html to be share
    ///
    /// - Parameters:
    ///   - indexPath: IndexPath
    ///   - fileManager: FileManager
    /// - Returns: URL
    func shareHtml(indexPath: IndexPath, fileManager: FileManager = FileManager.default) -> URL {
        let formAnswer = self.formViewModel.umbrella.formAnswers[indexPath.row]
        
        var form = Form()
        for formResult in self.formViewModel.umbrella.forms where formAnswer.formId == formResult.id {
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
        
        do {
            if let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = documentDirectory.appendingPathComponent("\(form.name.replacingOccurrences(of: " ", with: "_")).html")
                try html.write(to: fileURL, atomically: false, encoding: .utf8)
                return fileURL
            }
        } catch {
            print("error:", error)
        }
        
        return URL(string: "")!
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
        if self.formViewModel.umbrella.formAnswers.count > 0 {
            return 2
        }
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.formViewModel.umbrella.formAnswers.count > 0 {
            if section == 0 {
                return self.formViewModel.umbrella.formAnswers.count
            } else if section == 1 {
                return self.formViewModel.umbrella.forms.count
            }
        }
        
        return self.formViewModel.umbrella.forms.count
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
        if self.formViewModel.umbrella.formAnswers.count > 0 {
            if indexPath.section == 0 {
                return 140.0
            } else if indexPath.section == 1 {
                return 106.0
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
        
        if self.formViewModel.umbrella.formAnswers.count > 0 {
            if section == 0 {
                label.text = "Active".localized()
            } else if section == 1 {
                label.text = "Available forms".localized()
            }
        } else {
            label.text = "Available forms".localized()
        }
        
        view.addSubview(label)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.formViewModel.umbrella.formAnswers.count > 0 {
            if indexPath.section == 0 {
                // Active
                let formAnswer = self.formViewModel.umbrella.formAnswers[indexPath.row]
                
                for form in self.formViewModel.umbrella.forms where formAnswer.formId == form.id {
                    self.performSegue(withIdentifier: "fillFormSegue", sender: ["form": form, "formAnswer": formAnswer])
                }
                
            } else if indexPath.section == 1 {
                // Available Forms
                let form = self.formViewModel.umbrella.forms[indexPath.row]
                self.performSegue(withIdentifier: "fillFormSegue", sender: form)
            }
        } else {
            // Available Forms
            let form = self.formViewModel.umbrella.forms[indexPath.row]
            self.performSegue(withIdentifier: "fillFormSegue", sender: form)
        }
    }
}

//
// MARK: - FormCellDelegate
extension FormViewController: FormCellDelegate {
    
    func removeAction(indexPath: IndexPath) {
        UIAlertController.alert(title: "Alert", message: "Do you really want to remove this form?", cancelButtonTitle: "No", otherButtons: ["Yes"], dismiss: { _ in
            let formAnswer = self.formViewModel.umbrella.formAnswers[indexPath.row]
            self.formViewModel.umbrella.formAnswers.remove(at: indexPath.row)
            self.formViewModel.remove(formAnswerId: formAnswer.formAnswerId)
            self.formTableView.reloadData()
        }, cancel: {
            print("cancelClicked")
        })
    }
    
    func editAction(indexPath: IndexPath) {
        // Active
        let formAnswer = self.formViewModel.umbrella.formAnswers[indexPath.row]
        
        for form in self.formViewModel.umbrella.forms where formAnswer.formId == form.id {
            self.performSegue(withIdentifier: "fillFormSegue", sender: ["form": form, "formAnswer": formAnswer])
        }
    }
    
    func shareAction(indexPath: IndexPath) {
        let url = shareHtml(indexPath: indexPath)
        let objectsToShare = [url]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList, UIActivityType.saveToCameraRoll, UIActivityType.copyToPasteboard]
        
        activityVC.completionWithItemsHandler = {(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                return
            }
            // User completed activity
        }
        
        self.present(activityVC, animated: true, completion: nil)
    }
}
