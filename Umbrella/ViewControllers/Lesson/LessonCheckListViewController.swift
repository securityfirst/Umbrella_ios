//
//  LessonCheckListViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class LessonCheckListViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var lessonCheckListViewModel: LessonCheckListViewModel = {
        let lessonCheckListViewModel = LessonCheckListViewModel()
        return lessonCheckListViewModel
    }()
    @IBOutlet weak var checkListTableView: UITableView!
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CheckList"
        
        self.lessonCheckListViewModel.updateChecklistWithItemChecked()
        self.checkListTableView.reloadData()
        
        let modeBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.shareAction(_:)))
        self.navigationItem.rightBarButtonItem  = modeBarButton
        
        NotificationCenter.default.addObserver(self, selector: #selector(LessonCheckListViewController.updateChecklist(notification:)), name: Notification.Name("UpdateChecklist"), object: nil)
        
        updateProgress()
    }
    
    //
    // MARK: - Actions
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        
        var objectsToShare:[Any] = [Any]()
        
        var content: String = ""
        
        content += """
        <html>
        <head>
        <meta charset="UTF-8"> \n
        """
        content += "<title>\(self.lessonCheckListViewModel.category?.name ?? "")</title> \n"
        content += "</head> \n"
        content += "<body style=\"display:block;width:100%;\"> \n"
        content += "<h1>Checklist</h1> \n"
        
        for checkItem in (self.lessonCheckListViewModel.checklist?.items)! {
            content += "<label><input type=\"checkbox\"\(checkItem.checked ? "checked" : "") readonly onclick=\"return false;\">\(checkItem.name)</label><br> \n"
        }
        
        content += """
        </form>
        </body>
        </html>
        """
        
        UIAlertController.alertSheet(title: "Alert".localized(), message: "Choose the format.".localized(), buttons: ["HTML", "PDF"], dismiss: { (option) in
            
            if option == 0 {
                // HTML
                let html = HTML(nameFile: "Checklist.html", content: content)
                let export = Export(html)
                let url = export.makeExport()
                objectsToShare = [url]
            } else if option == 1 {
                //PDF
                let pdf = PDF(nameFile: "Checklist.pdf", content: content)
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
    
    //
    // MARK: - Functions
    
    /// Update the progress of the progressBar
    fileprivate func updateProgress() {
        
        if let currentChecked = (self.lessonCheckListViewModel.checklist?.items.filter {$0.checked == true }.count), let totalItemInChecklist = self.lessonCheckListViewModel.checklist?.countItemCheck() {
            self.progressView.setProgress(Float(currentChecked)/Float(totalItemInChecklist), animated: true)
            self.progressLabel.text = "\(Int(CGFloat(currentChecked) / CGFloat(totalItemInChecklist) * 100))%"
        }
    }
    
    /// Update Checklist
    ///
    /// - Parameter notification: NSNotification
    @objc func updateChecklist(notification: NSNotification) {
        self.lessonCheckListViewModel.updateChecklistWithItemChecked()
        self.checkListTableView.reloadData()
        
        updateProgress()
    }
    
}

// MARK: - UITableViewDataSource
extension LessonCheckListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let checklist = self.lessonCheckListViewModel.checklist {
            return checklist.items.count
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let checklist = self.lessonCheckListViewModel.checklist {
            let item: CheckItem = checklist.items[indexPath.row]
            
            if item.isLabel {
                let cell: CheckListLabelCell = (tableView.dequeueReusableCell(withIdentifier: "CheckListLabelCell", for: indexPath) as? CheckListLabelCell)!
                
                cell.configure(withViewModel: self.lessonCheckListViewModel, indexPath: indexPath)
                
                return cell
            } else {
                let cell: FillCheckListCell = (tableView.dequeueReusableCell(withIdentifier: "FillCheckListCell", for: indexPath) as? FillCheckListCell)!
                
                cell.configure(withViewModel: self.lessonCheckListViewModel, indexPath: indexPath)
                
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension LessonCheckListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let item: CheckItem = self.lessonCheckListViewModel.checklist!.items[indexPath.row]
        
        if item.isLabel {
            return 50.0
        } else {
            return 80.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var categoryFound: Category? = nil
        
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        
        let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
        
        for category in UmbrellaDatabase.categories(lang: languageName) {
            if category.id == self.lessonCheckListViewModel.category?.parent {
                categoryFound = category
                break
            }
            
            let categoryFilter = category.categories.filter {$0.id == self.lessonCheckListViewModel.category?.parent }.first
            
            if let category = categoryFilter {
                categoryFound = category
                break
            }
        }
        
        let subCategory = categoryFound
        let difficulty = self.lessonCheckListViewModel.category
        let checklist = self.lessonCheckListViewModel.checklist
        let item: CheckItem = self.lessonCheckListViewModel.checklist!.items[indexPath.row]
        
        let checklistChecked = ChecklistChecked(subCategoryName: subCategory!.name ?? "", subCategoryId: subCategory!.id, difficultyId: difficulty!.id, checklistId: checklist!.id, itemId: item.id, totalItemsChecklist: checklist!.countItemCheck())
        checklistChecked.languageId = language!.id
        item.checked = !item.checked
        
        if item.checked {
            self.lessonCheckListViewModel.insert(checklistChecked)
        } else {
            self.lessonCheckListViewModel.remove(checklistChecked)
        }
        
        self.updateProgress()

        // I have created this notification to update when a user marks check or uncheck an item on the checklist tab or lesson tab. This way both will be updated
        NotificationCenter.default.post(name: Notification.Name("UpdateChecklist"), object: nil)
    }
}
