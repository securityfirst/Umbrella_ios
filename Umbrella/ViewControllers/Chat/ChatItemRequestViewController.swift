//
//  ChatItemRequestViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 01/07/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ChatItemRequestViewController: UIViewController {
    //
    // MARK: - Properties
    @IBOutlet weak var chatItemRequestTableView: UITableView!
    @IBOutlet weak var sendBottomConstraint: NSLayoutConstraint!
    lazy var chatItemRequestViewModel: ChatItemRequestViewModel = {
        let chatItemRequestViewModel = ChatItemRequestViewModel()
        return chatItemRequestViewModel
    }()
    
    lazy var chatMessageViewModel: ChatMessageViewModel = {
        let chatMessageViewModel = ChatMessageViewModel()
        return chatMessageViewModel
    }()
    
    lazy var checklistViewModel: ChecklistViewModel = {
        let checklistViewModel = ChecklistViewModel()
        return checklistViewModel
    }()
    
    @IBOutlet weak var sendButton: UIButton!
    var itemSelected: [IndexPath] = [IndexPath]() {
        didSet {
            if itemSelected.count > 0 {
                self.sendButton.setTitle("Send", for: .normal)
                self.sendBottomConstraint.constant = 44
            } else {
                self.sendButton.setTitle("", for: .normal)
                self.sendBottomConstraint.constant = 0
            }
            
            UIView.animate(withDuration: 0.2,
                           delay: 0,
                           options: [.curveEaseOut, .beginFromCurrentState],
                           animations: {
                            self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width: 300, height: 250)
        
        self.title = self.chatItemRequestViewModel.item.name
        
        switch self.chatItemRequestViewModel.item.type {
        case .forms:
            break
        case .checklists:
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
            controller.showLoading(view: self.view)
            DispatchQueue.global(qos: .default).async {
                self.checklistViewModel.reportOfItemsChecked()
                self.chatItemRequestViewModel.checklistChecked = self.checklistViewModel.checklistChecked
                self.chatItemRequestViewModel.favouriteChecklistChecked = self.checklistViewModel.favouriteChecklistChecked
                DispatchQueue.main.async {
                    controller.closeLoading()
                    self.chatItemRequestTableView.reloadData()
                }
            }
        case .answers:
            break
        default:
            break
        }
    }
    
    fileprivate func exportFormJSON() -> (url: URL, filename: String) {
        do {
            var formAnswer = FormAnswer()
            var form = Form()
            var formAnswers: [FormAnswer] = [FormAnswer]()
            
            let indexPath = self.itemSelected.first!
            
            if indexPath.section == 0 {
                form = self.chatItemRequestViewModel.umbrella.loadFormByCurrentLanguage()[indexPath.row]
            } else if indexPath.section == 1 {
                formAnswer = self.chatItemRequestViewModel.umbrella.loadFormAnswersByCurrentLanguage()[indexPath.row]
                
                for formResult in self.chatItemRequestViewModel.umbrella.loadFormByCurrentLanguage() where formAnswer.formId == formResult.id {
                    form = formResult
                }
                
                formAnswers = self.chatItemRequestViewModel.loadFormAnswersTo(formAnswerId: formAnswer.formAnswerId, formId: form.id)
            }
            
            for screen in form.screens {
                
                for item in screen.items {
                    switch item.formType {
                    case .textInput:
                        for formAnswer in formAnswers where formAnswer.itemFormId == item.id {
                            item.answer = formAnswer.text
                        }
                    case .textArea:
                        for formAnswer in formAnswers where formAnswer.itemFormId == item.id {
                            item.answer = formAnswer.text
                        }
                    case .multiChoice:
                        for optionItem in item.options {
                            for formAnswer in formAnswers where formAnswer.itemFormId == item.id && formAnswer.optionItemId == optionItem.id {
                                optionItem.answer = 1
                            }
                        }
                    case .singleChoice:
                        for optionItem in item.options {
                            for formAnswer in formAnswers where formAnswer.itemFormId == item.id && formAnswer.optionItemId == optionItem.id {
                                optionItem.answer = 1
                            }
                        }
                    case .label:
                        break
                    case .none:
                        break
                    }
                }
            }
            
            let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
            
            var matrixFile = MatrixFile()
            matrixFile.matrixType = "form"
            matrixFile.language = languageName
            matrixFile.name = form.name
            matrixFile.object = form
            
            let data = try JSONEncoder().encode(matrixFile)
            let jsonString = String(data: data, encoding: String.Encoding.utf8)!
            
            let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(),
                                            isDirectory: true)
            let filename = form.name.replacingOccurrences(of: " ", with: "_")   + ".json"
            let fileURL = temporaryDirectoryURL.appendingPathComponent(filename)
            try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
            return (url: fileURL, filename: filename)
        } catch {
            print(error)
        }
        
        return (url: URL(string: "")!, filename: "")
    }
    
    @IBAction func sendAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        switch self.chatItemRequestViewModel.item.type {
        case .forms:
            if itemSelected.count > 0 {
                
                let json = exportFormJSON()
                
//                let shareItem = self.prepareHtml(indexPath: self.itemSelected.first!)
//                let filename = shareItem.nameFile + ".pdf"
//                let pdf = PDF(nameFile: filename, content: shareItem.content)
//                let export = Export(pdf)
//                let url = export.makeExport()
                //
                DispatchQueue.global(qos: .background).async {
                    self.chatItemRequestViewModel.uploadFile(filename: json.filename, fileURL: json.url, success: { (response) in
                        
                        guard let url = response as? String else {
                            print("Error cast response to String")
                            return
                        }
                        
                        self.chatMessageViewModel.sendMessage(messageType: .file,
                                                              message: json.filename,
                                                              url: url,
                                                              success: { _ in
                                                                NotificationCenter.default.post(name: Notification.Name("UpdateMessages"), object: nil)
                        }, failure: { (response, object, error) in
                            print(error ?? "")
                        })
                    }, failure: { (response, object, error) in
                        print(error ?? "")
                    })
                }
            }
        case .checklists:
            
            if itemSelected.count > 0 {
                var checklistChecked: ChecklistChecked? = ChecklistChecked()
                if itemSelected[0].section == 0 {
                    checklistChecked = self.chatItemRequestViewModel.favouriteChecklistChecked[itemSelected[0].row]
                } else if itemSelected[0].section == 1 {
                    checklistChecked = self.chatItemRequestViewModel.checklistChecked[itemSelected[0].row]
                }
                
                if let checklistChecked = checklistChecked {
                    let checklist = self.checklistViewModel.getChecklist(checklistId: checklistChecked.checklistId)
                    
                    var content: String = ""
                    
                    content += """
                    <html>
                    <head>
                    <meta charset="UTF-8"> \n
                    """
                    content += "<title>Checklist</title> \n"
                    content += "</head> \n"
                    content += "<body style=\"display:block;width:100%;\"> \n"
                    content += "<h1>Checklist</h1> \n"
                    
                    for checkItem in checklist.items {
                        checkItem.answer = checkItem.checked ? 1 : 0
                        content += "<label><input type=\"checkbox\"\(checkItem.checked ? "checked" : "") readonly onclick=\"return false;\">\(checkItem.name)</label><br> \n"
                    }
                    
                    content += """
                    </form>
                    </body>
                    </html>
                    """
                    
//                    let name = checklistChecked.subCategoryName.replacingOccurrences(of: " ", with: "_")
//                    //PDF
//                    let filename = "\(name)_Checklist.pdf"
//                    let pdf = PDF(nameFile: filename, content: content)
//                    let export = Export(pdf)
//                    let url = export.makeExport()

                    let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
                    
                    var matrixFile = MatrixFile()
                    matrixFile.matrixType = "checklist"
                    matrixFile.language = languageName
                    matrixFile.name = checklistChecked.subCategoryName
                    
                    let difficulty = self.chatItemRequestViewModel.searchCategoryBy(id: checklistChecked.difficultyId)
                    matrixFile.extra = difficulty?.name ?? ""
                    
                    matrixFile.object = checklist
                    
                    let data = try! JSONEncoder().encode(matrixFile)
                    let jsonString = String(data: data, encoding: String.Encoding.utf8)!
                    
                    let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(),
                                                    isDirectory: true)
                    let filename = checklistChecked.subCategoryName.replacingOccurrences(of: " ", with: "_")   + ".json"
                    let fileURL = temporaryDirectoryURL.appendingPathComponent(filename)
                    try! jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
                    
                    DispatchQueue.global(qos: .background).async {
                        self.chatItemRequestViewModel.uploadFile(filename: filename, fileURL: fileURL, success: { (response) in
                            
                            guard let url = response as? String else {
                                print("Error cast response to String")
                                return
                            }
                            
                            self.chatMessageViewModel.sendMessage(messageType: .file,
                                                                  message: filename,
                                                                  url: url,
                                                                  success: { _ in
                                                                    NotificationCenter.default.post(name: Notification.Name("UpdateMessages"), object: nil)
                            }, failure: { (response, object, error) in
                                print(error ?? "")
                            })
                        }, failure: { (response, object, error) in
                            print(error ?? "")
                        })
                    }
                }
            }
        case .answers:
            break
        default:
            break
        }
        
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
        
        var formAnswer = FormAnswer()
        var form = Form()
        var formAnswers: [FormAnswer] = [FormAnswer]()
        
        if indexPath.section == 0 {
            form = self.chatItemRequestViewModel.umbrella.loadFormByCurrentLanguage()[indexPath.row]
        } else if indexPath.section == 1 {
            formAnswer = self.chatItemRequestViewModel.umbrella.loadFormAnswersByCurrentLanguage()[indexPath.row]
            
            for formResult in self.chatItemRequestViewModel.umbrella.loadFormByCurrentLanguage() where formAnswer.formId == formResult.id {
                form = formResult
            }
            
            formAnswers = self.chatItemRequestViewModel.loadFormAnswersTo(formAnswerId: formAnswer.formAnswerId, formId: form.id)
        }
        
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
                html += "<h5>\(item.label)</h5> \n"
                
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
    
}

// MARK: - UITableViewDataSource
extension ChatItemRequestViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        switch self.chatItemRequestViewModel.item.type {
        case .forms:
            if self.chatItemRequestViewModel.umbrella.loadFormAnswersByCurrentLanguage().count > 0 {
                return 2
            }
            return 1
        case .checklists:
            return 2
        case .answers:
            return 1
        default:
            return 1
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.chatItemRequestViewModel.item.type {
        case .forms:
            if self.chatItemRequestViewModel.umbrella.loadFormAnswersByCurrentLanguage().count > 0 {
                if section == 0 {
                    return self.chatItemRequestViewModel.umbrella.loadFormByCurrentLanguage().count
                } else if section == 1 {
                    return self.chatItemRequestViewModel.umbrella.loadFormAnswersByCurrentLanguage().count
                }
            }
            
            return self.chatItemRequestViewModel.umbrella.loadFormByCurrentLanguage().count
        case .checklists:
            if section == 0 {
                return self.chatItemRequestViewModel.favouriteChecklistChecked.count
            } else if section == 1 {
                return self.chatItemRequestViewModel.checklistChecked.count
            }
            return 0
        case .answers:
            return 0
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatItemRequestCell = (tableView.dequeueReusableCell(withIdentifier: "ChatItemRequestCell", for: indexPath) as? ChatItemRequestCell)!
        cell.configure(withViewModel: self.chatItemRequestViewModel, indexPath: indexPath)
        cell.iconImageView.image = itemSelected.contains(indexPath) ? #imageLiteral(resourceName: "checkSelected") : #imageLiteral(resourceName: "groupNormal")
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ChatItemRequestViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch self.chatItemRequestViewModel.item.type {
        case .forms:
            return 30
        case .checklists:
            return 30
        case .answers:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: 30))
        label.font = UIFont.init(name: "SFProText-SemiBold", size: 12)
        label.textColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5764705882, alpha: 1)
        
        switch self.chatItemRequestViewModel.item.type {
        case .forms:
            if self.chatItemRequestViewModel.umbrella.loadFormAnswersByCurrentLanguage().count > 0 {
                if section == 0 {
                    label.text = "Available forms".localized()
                } else if section == 1 {
                    label.text = "Active".localized()
                }
            } else {
                label.text = "Available forms".localized()
            }
            
            view.addSubview(label)
        case .checklists:
            if section == 0 {
                label.text = "Favourites".localized()
            } else if section == 1 {
                label.text = "My Checklists".localized()
            }
            
            view.addSubview(label)
        case .answers:
            break
        default:
            break
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemSelected.removeAll()
        itemSelected.append(indexPath)
        tableView.reloadData()
    }
}
