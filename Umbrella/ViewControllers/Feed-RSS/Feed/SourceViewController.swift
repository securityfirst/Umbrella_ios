//
//  SourceViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class SourceViewController: UIViewController {

    var sources = [
        (name: "ReliefWeb", code: 0),
        (name: "UN", code: 1),
        (name: "FCO", code: 2),
        (name: "CDC", code: 3),
        (name: "Global Disaster and Alert Coordination System", code: 4),
        (name: "US State Department Country Warnings", code: 5)
    ]
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
    }
    
}

// MARK: - UITableViewDataSource
extension SourceViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sources.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SourceCell = (tableView.dequeueReusableCell(withIdentifier: "SourceCell", for: indexPath) as? SourceCell)!
        
        let source = self.sources[indexPath.row]
        cell.titleLabel?.text = source.name
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SourceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}
