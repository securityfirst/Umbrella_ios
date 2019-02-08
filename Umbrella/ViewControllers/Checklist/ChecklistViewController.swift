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
        self.emptyLabel?.text = "Go to lessons and discover recommenced checklists or create your own custom checklists.".localized()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLanguage()
        self.checklistReviewTableView?.register(ChecklistReviewHeaderView.nib, forHeaderFooterViewReuseIdentifier: ChecklistReviewHeaderView.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.checklistViewModel.reportOfItemsChecked()
        
        self.emptyLabel.isHidden = !(self.checklistViewModel.checklistChecked.count == 0 && self.checklistViewModel.favouriteChecklistChecked.count == 0)
        self.checklistReviewTableView.isHidden = (self.checklistViewModel.checklistChecked.count == 0 && self.checklistViewModel.favouriteChecklistChecked.count == 0)
        
        self.checklistReviewTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Update Language
    @objc func updateLanguage() {
        self.title = "Checklists".localized()
        self.emptyLabel.text = "Go to lessons and discover recommenced checklists or create your own custom checklists.".localized()
        self.checklistReviewTableView?.reloadData()
    }
    
    //
    // MARK: - UIStoryboardSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checklistDetailSegue" {
            let destination = (segue.destination as? LessonCheckListViewController)!
            let item = (sender as? (category: Category, checkList: CheckList))!
            destination.lessonCheckListViewModel.checklist = item.checkList
            destination.lessonCheckListViewModel.category = item.category
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var item = (Category(), CheckList())
        if indexPath.section == 1 {
            let checklistChecked = self.checklistViewModel.favouriteChecklistChecked[indexPath.row]
            item = self.checklistViewModel.getChecklistAndCategory(to: checklistChecked.checklistId)
        } else if indexPath.section == 2 {
            let checklistChecked = self.checklistViewModel.checklistChecked[indexPath.row]
            item = self.checklistViewModel.getChecklistAndCategory(to: checklistChecked.checklistId)
        }
        
        self.performSegue(withIdentifier: "checklistDetailSegue", sender: item)
    }
}
