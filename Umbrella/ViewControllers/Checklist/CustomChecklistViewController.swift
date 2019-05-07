//
//  CustomChecklistViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 03/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class CustomChecklistViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var customChecklistViewModel: CustomChecklistViewModel = {
        let customChecklistViewModel = CustomChecklistViewModel()
        return customChecklistViewModel
    }()
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var customTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emptyLabel?.text = "Press + button to create your custom checklist.".localized()
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UmbrellaDatabase.loadedContent {
            updateChecklist()
        }
    }
    
    // MARK: - Functions
    
    /// Update Language
    @objc func updateLanguage() {
        self.title = "Checklists".localized()
        self.emptyLabel?.text = "Press + button to create your custom checklist.".localized()
        if UmbrellaDatabase.loadedContent {
            updateChecklist()
        }
    }
    
    /// Loading the checklist
    func updateChecklist() {
        DispatchQueue.global(qos: .default).async {
            self.customChecklistViewModel.loadCustomChecklist()
            DispatchQueue.main.async {
                self.emptyLabel.isHidden = !(self.customChecklistViewModel.customChecklists.count == 0)
                self.customTableView.isHidden = (self.customChecklistViewModel.customChecklists.count == 0)
                self.customTableView.reloadData()
            }
        }
    }
    
    //
    // MARK: - UIStoryboardSegue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newSegue" {
            let destination = (segue.destination as? NewChecklistViewController)!
            destination.newChecklistViewModel.name = (sender as? String)!
            
            let customChecklist = self.customChecklistViewModel.insertCustomChecklist(name: destination.newChecklistViewModel.name)
            destination.newChecklistViewModel.customChecklist = customChecklist
        } else if segue.identifier == "editSegue" {
            let destination = (segue.destination as? NewChecklistViewController)!
            let customChecklist = (sender as? CustomChecklist)!
            destination.newChecklistViewModel.name = customChecklist.name
            destination.newChecklistViewModel.customChecklist = customChecklist
        }
    }
}

// MARK: - UITableViewDataSource
extension CustomChecklistViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customChecklistViewModel.customChecklists.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CustomChecklistCell = (tableView.dequeueReusableCell(withIdentifier: "CustomChecklistCell", for: indexPath) as? CustomChecklistCell)!
        
        cell.configure(withViewModel: self.customChecklistViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CustomChecklistViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete".localized()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { (action, indexPath) in
            let customChecklist = self.customChecklistViewModel.customChecklists[indexPath.row]
            self.customChecklistViewModel.customChecklists.remove(at: indexPath.row)
            self.customChecklistViewModel.removeCustomChecklist(customChecklist: customChecklist)
            self.customTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            if self.customChecklistViewModel.customChecklists.count == 0 {
                self.emptyLabel.isHidden = !(self.customChecklistViewModel.customChecklists.count == 0)
                self.customTableView.isHidden = (self.customChecklistViewModel.customChecklists.count == 0)
            }
        }
        
        delete.backgroundColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let customChecklist = self.customChecklistViewModel.customChecklists[indexPath.row]
        self.performSegue(withIdentifier: "editSegue", sender: customChecklist)
    }
}
