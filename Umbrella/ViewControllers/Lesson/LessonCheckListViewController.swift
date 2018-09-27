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
        
        updateProgress()
    }
    
    //
    // MARK: - Actions
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        
    }
    
    //
    // MARK: - Functions
    
    /// Update the progress of the progressBar
    fileprivate func updateProgress() {
        
        if let currentChecked = (self.lessonCheckListViewModel.checklist?.items.filter {$0.checked == true }.count), let totalItemInChecklist = self.lessonCheckListViewModel.checklist?.items.count {
            self.progressView.setProgress(Float(currentChecked)/Float(totalItemInChecklist), animated: true)
            self.progressLabel.text = "\(Int(CGFloat(currentChecked) / CGFloat(totalItemInChecklist) * 100))%"
        }
    }

}

// MARK: - UITableViewDataSource
extension LessonCheckListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lessonCheckListViewModel.checklist!.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item: CheckItem = self.lessonCheckListViewModel.checklist!.items[indexPath.row]
        
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
        
        for category in UmbrellaDatabase.categories() {
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
        
        let checklistChecked = ChecklistChecked(subCategoryName: subCategory!.name ?? "", subCategoryId: subCategory!.id, difficultyId: difficulty!.id, checklistId: checklist!.id, itemId: item.id, totalItemsChecklist: checklist!.items.count)
        item.checked = !item.checked
        
        if item.checked {
            self.lessonCheckListViewModel.insert(checklistChecked)
        } else {
            self.lessonCheckListViewModel.remove(checklistChecked)
        }
        
        self.updateProgress()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}
