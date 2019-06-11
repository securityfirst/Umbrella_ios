//
//  ChecklistViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class ChecklistViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var checklistViewModel: ChecklistViewModel = {
        let checklistViewModel = ChecklistViewModel()
        return checklistViewModel
    }()
    
    lazy var pathwayViewModel: PathwayViewModel = {
        let pathwayViewModel = PathwayViewModel()
        return pathwayViewModel
    }()
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var checklistReviewTableView: UITableView!
    
    var pathwayViewController: PathwayViewController!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.emptyLabel?.text = "Go to lessons and discover recommended checklists or create your own custom checklists.".localized()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checklistReviewTableView?.register(ChecklistReviewHeaderView.nib, forHeaderFooterViewReuseIdentifier: ChecklistReviewHeaderView.identifier)
        self.checklistReviewTableView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        if UmbrellaDatabase.loadedContent {
            updateChecklist()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Update Language
    @objc func updateLanguage() {
        self.title = "Checklists".localized()
        self.emptyLabel.text = "Go to lessons and discover recommended checklists or create your own custom checklists.".localized()
        if UmbrellaDatabase.loadedContent {
            updateChecklist()
        }
    }
    
    /// Loading the checklist
    func updateChecklist() {
        DispatchQueue.global(qos: .default).async {
            self.checklistViewModel.reportOfItemsChecked()
            
            let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
            let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
            
            if let language = language {
                let success = self.pathwayViewModel.listPathways(languageId: language.id)
                if success {
                    self.pathwayViewModel.updatePathways()
                }
                
                DispatchQueue.main.async {
                    self.emptyLabel.isHidden = true
                    self.checklistReviewTableView.isHidden = false
                    //                self.emptyLabel.isHidden = !(self.checklistViewModel.checklistChecked.count == 0 && self.checklistViewModel.favouriteChecklistChecked.count == 0)
                    //                self.checklistReviewTableView.isHidden = (self.checklistViewModel.checklistChecked.count == 0 && self.checklistViewModel.favouriteChecklistChecked.count == 0)
                    
                    self.checklistReviewTableView.reloadData()
                }
            }
        }
    }
    
    /// Show Pathway screen
    ///
    /// - Returns: Bool
    func showPathway() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.pathwayViewController = (storyboard.instantiateViewController(withIdentifier: "PathwayViewController") as? PathwayViewController)!
        self.present(self.pathwayViewController, animated: true, completion: nil)
    }
    
    //
    // MARK: - UIStoryboardSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checklistDetailSegue" {
            
            let destination = (segue.destination as? LessonCheckListViewController)!
            let item = (sender as? (category: Category, subCategory: Category, difficulty: Category, checklist: CheckList))!
            destination.pathwayViewModel.checklist = item.checklist
            destination.pathwayViewModel.category = item.category
            destination.isLoadingPathwayItems = true
        }
    }
}

// MARK: - UITableViewDataSource
extension ChecklistViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            let checklists = self.pathwayViewModel.pathwayFavorite()
            return checklists.count + 1
        } else if section == 2 {
            return self.checklistViewModel.favouriteChecklistChecked.count
        } else if section == 3 {
            return self.checklistViewModel.checklistChecked.count
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let checklists = self.pathwayViewModel.pathwayFavorite()
            
            print("\(indexPath.row) \(checklists.count)")
            if indexPath.row == checklists.count {
                let cell: PathwaySeeAllCell = (tableView.dequeueReusableCell(withIdentifier: "PathwaySeeAllCell", for: indexPath) as? PathwaySeeAllCell)!
                cell.configure()
                return cell
            } else {
                let cell: PathwayChecklistCell = (tableView.dequeueReusableCell(withIdentifier: "PathwayChecklistCell", for: indexPath) as? PathwayChecklistCell)!
                cell.configure(withViewModel: self.pathwayViewModel, indexPath: indexPath)
                cell.delegate = self
                return cell
            }
        } else {
            let cell: ChecklistReviewCell = (tableView.dequeueReusableCell(withIdentifier: "ChecklistReviewCell", for: indexPath) as? ChecklistReviewCell)!
            cell.configure(withViewModel: self.checklistViewModel, indexPath: indexPath)
            cell.delegate = self
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate
extension ChecklistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            let checklists = self.pathwayViewModel.pathwayFavorite()
            if indexPath.row == checklists.count {
                return 44
            }
        }
        return 96.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 39.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChecklistReviewHeaderView.identifier) as? ChecklistReviewHeaderView {
            
            if section == 0 {
                headerView.titleLabel.text = "Checklists total".localized()
            } else if section == 1 {
                headerView.titleLabel.text = "Top Tips".localized()
            } else if section == 2 {
                headerView.titleLabel.text = "Favourites".localized()
            } else if section == 3 {
                headerView.titleLabel.text = "My Checklists".localized()
            }
            
            headerView.section = section
            
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            
            if indexPath.section == 2 {
                // Favorite
                let checklistChecked = self.checklistViewModel.favouriteChecklistChecked[indexPath.row]
                self.checklistViewModel.removelAllChecks(checklistChecked: checklistChecked)
                self.checklistViewModel.favouriteChecklistChecked.remove(at: indexPath.row)
                let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
                let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
                let newChecklistChecked = ChecklistChecked(subCategoryName: checklistChecked.subCategoryName, subCategoryId: checklistChecked.subCategoryId, difficultyId: checklistChecked.difficultyId, checklistId: checklistChecked.checklistId, languageId:language!.id)
                newChecklistChecked.totalItemsChecklist = checklistChecked.totalItemsChecklist
                self.checklistViewModel.insert(newChecklistChecked)
                self.checklistViewModel.favouriteChecklistChecked.append(newChecklistChecked)
            } else if indexPath.section == 3 {
                // My checklists
                let checklistChecked = self.checklistViewModel.checklistChecked[indexPath.row]
                self.checklistViewModel.checklistChecked.remove(at: indexPath.row)
                self.checklistViewModel.removelAllChecks(checklistChecked: checklistChecked)
            }
            
            self.emptyLabel.isHidden = !(self.checklistViewModel.checklistChecked.count == 0 && self.checklistViewModel.favouriteChecklistChecked.count == 0)
            self.checklistReviewTableView.isHidden = (self.checklistViewModel.checklistChecked.count == 0 && self.checklistViewModel.favouriteChecklistChecked.count == 0)
            
            self.checklistReviewTableView.reloadData()
            
            NotificationCenter.default.post(name: Notification.Name("UpdateChecklist"), object: nil)
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 || indexPath.section == 1 {
            return false
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var item = (category: Category(), subCategory: Category(), difficulty: Category(), checklist: CheckList())
        if indexPath.section == 1 {
            let checklists = self.pathwayViewModel.pathwayFavorite()
            
            if indexPath.row == checklists.count {
                self.showPathway()
            } else {
                let checklist = self.pathwayViewModel.pathwayFavorite()[indexPath.row]
                item.checklist = checklist
                item.category = self.pathwayViewModel.category!
                self.performSegue(withIdentifier: "checklistDetailSegue", sender: item)
            }
        } else if indexPath.section == 2 {
            let checklistChecked = self.checklistViewModel.favouriteChecklistChecked[indexPath.row]
            item = self.checklistViewModel.getStructureOfObject(to: checklistChecked.checklistId)
        } else if indexPath.section == 3 {
            let checklistChecked = self.checklistViewModel.checklistChecked[indexPath.row]
            item = self.checklistViewModel.getStructureOfObject(to: checklistChecked.checklistId)
        }
        
        if indexPath.section != 0 {
            let url = URL(string: "umbrella://\(item.category.deeplink!)/\( item.subCategory.deeplink!)/\( item.difficulty.deeplink!)/checklist/\(item.checklist.id)")
            UIApplication.shared.open(url!)
        }
    }
    
    /// Normalize name of a category
    ///
    /// - Parameter name: String
    /// - Returns: String
    func normalizeName(name: String?) -> String {
        
        if let name = name {
            return name.replacingOccurrences(of: " ", with: "-").lowercased()
        }
        return ""
    }
}

// MARK: - ChecklistReviewCellDelegate
extension ChecklistViewController: ChecklistReviewCellDelegate {
    func shareChecklist(cell: ChecklistReviewCell, indexPath: IndexPath) {
        var objectsToShare:[Any] = [Any]()
        
        var checklistChecked: ChecklistChecked? = ChecklistChecked()
        if indexPath.section == 2 {
            checklistChecked = self.checklistViewModel.favouriteChecklistChecked[indexPath.row]
        } else if indexPath.section == 3 {
            checklistChecked = self.checklistViewModel.checklistChecked[indexPath.row]
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
                content += "<label><input type=\"checkbox\"\(checkItem.checked ? "checked" : "") readonly onclick=\"return false;\">\(checkItem.name)</label><br> \n"
            }
            
            content += """
            </form>
            </body>
            </html>
            """
            
            UIAlertController.alertSheet(title: "", message: "Choose the format.".localized(), buttons: ["HTML", "PDF"], dismiss: { (option) in
                
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
    }
}

// MARK: - PathwayChecklistCellDelegate
extension ChecklistViewController: PathwayChecklistCellDelegate {
    func deletePathwayChecklist(cell: PathwayChecklistCell, indexPath: IndexPath) {
        UIAlertController.alert(title: "Alert".localized(), message: "Do you really want to remove this item?".localized(), cancelButtonTitle: "No".localized(), otherButtons: ["Yes".localized()], dismiss: { _ in
            
            let checklist: CheckList = self.pathwayViewModel.pathwayFavorite()[indexPath.row]
            self.pathwayViewModel.removelAllChecks(checklist: checklist)
            checklist.favourite = false
            self.checklistReviewTableView.reloadData()
        }, cancel: {
            print("cancelClicked")
        })
    }
}
