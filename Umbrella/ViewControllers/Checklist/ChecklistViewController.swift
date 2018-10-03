//
//  ChecklistViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class ChecklistViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var checklistViewModel: ChecklistViewModel = {
        let checklistViewModel = ChecklistViewModel()
        return checklistViewModel
    }()
    
    @IBOutlet weak var checklistReviewTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Checklists".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checklistReviewTableView?.register(ChecklistReviewHeaderView.nib, forHeaderFooterViewReuseIdentifier: ChecklistReviewHeaderView.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            return 0
        } else if section == 2 {
            return 2
        }
        
        return self.checklistViewModel.checklistChecked.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            
        } else if indexPath.section == 2 {
            
        }
        
        let cell: ChecklistReviewCell = (tableView.dequeueReusableCell(withIdentifier: "ChecklistReviewCell", for: indexPath) as? ChecklistReviewCell)!
        
        //        cell.configure(withViewModel: self.checklistViewModel, indexPath: indexPath)
        
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
        
    }
}
