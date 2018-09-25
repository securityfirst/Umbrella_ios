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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CheckList"
    }

}

// MARK: - UITableViewDataSource
extension LessonCheckListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lessonCheckListViewModel.checkList!.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item: CheckItem = self.lessonCheckListViewModel.checkList!.items[indexPath.row]
        
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
        
        let item: CheckItem = self.lessonCheckListViewModel.checkList!.items[indexPath.row]
        
        if item.isLabel {
            return 50.0
        } else {
            return 80.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
        UmbrellaDatabase.categories().flatMap{$0.categories}.flatMap($0).
        let item: CheckItem = self.lessonCheckListViewModel.checkList!.items[indexPath.row]
        item.checked = !item.checked
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}
