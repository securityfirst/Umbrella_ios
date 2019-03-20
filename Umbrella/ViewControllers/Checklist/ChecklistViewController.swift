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
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var checklistReviewTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.emptyLabel?.text = "Go to lessons and discover recommended checklists or create your own custom checklists.".localized()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLanguage()
        self.checklistReviewTableView?.register(ChecklistReviewHeaderView.nib, forHeaderFooterViewReuseIdentifier: ChecklistReviewHeaderView.identifier)
        self.checklistReviewTableView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        DispatchQueue.global(qos: .default).async {
            self.checklistViewModel.reportOfItemsChecked()
            DispatchQueue.main.async {
                self.emptyLabel.isHidden = !(self.checklistViewModel.checklistChecked.count == 0 && self.checklistViewModel.favouriteChecklistChecked.count == 0)
                self.checklistReviewTableView.isHidden = (self.checklistViewModel.checklistChecked.count == 0 && self.checklistViewModel.favouriteChecklistChecked.count == 0)
                
                self.checklistReviewTableView.reloadData()
            }
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
        self.checklistReviewTableView?.reloadData()
    }
    
    //
    // MARK: - UIStoryboardSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checklistDetailSegue" {
            let destination = (segue.destination as? LessonCheckListViewController)!
            let item = (sender as? (category: Category, subCategory: Category, difficulty: Category, checkList: CheckList))!
            destination.lessonCheckListViewModel.checklist = item.checkList
            destination.lessonCheckListViewModel.category = item.difficulty
        }
    }
}

// MARK: - UITableViewDataSource
extension ChecklistViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return self.checklistViewModel.favouriteChecklistChecked.count
        } else if section == 2 {
            return self.checklistViewModel.checklistChecked.count
        }
        
        return self.checklistViewModel.checklistChecked.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ChecklistReviewCell = (tableView.dequeueReusableCell(withIdentifier: "ChecklistReviewCell", for: indexPath) as? ChecklistReviewCell)!
        cell.configure(withViewModel: self.checklistViewModel, indexPath: indexPath)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ChecklistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
                headerView.titleLabel.text = "Favourites".localized()
            } else if section == 2 {
                headerView.titleLabel.text = "My Checklists".localized()
            }
            
            headerView.section = section
            
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            
            if indexPath.section == 1 {
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
            } else if indexPath.section == 2 {
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
        if indexPath.section == 0 {
            return false
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var item = (category: Category(), subCategory: Category(), difficulty: Category(), checklist: CheckList())
        if indexPath.section == 1 {
            let checklistChecked = self.checklistViewModel.favouriteChecklistChecked[indexPath.row]
            item = self.checklistViewModel.getStructureOfObject(to: checklistChecked.checklistId)
        } else if indexPath.section == 2 {
            let checklistChecked = self.checklistViewModel.checklistChecked[indexPath.row]
            item = self.checklistViewModel.getStructureOfObject(to: checklistChecked.checklistId)
        }
        
        if indexPath.section != 0 {
//            self.performSegue(withIdentifier: "checklistDetailSegue", sender: item)
            let url = URL(string: "umbrella://\(normalizeName(name: item.category.name))/\(normalizeName(name: item.subCategory.name))/\(normalizeName(name: item.difficulty.name))/checklist/\(item.checklist.id)")
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
