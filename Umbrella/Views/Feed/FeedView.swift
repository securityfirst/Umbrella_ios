//
//  FeedView.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FeedView: UIView {

    //
    // MARK: - Properties
    
    //
    // MARK: - Life cycle
    
}

// MARK: - UITableViewDataSource
extension FeedView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.formViewModel.umbrella.forms.count
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FormCell = (tableView.dequeueReusableCell(withIdentifier: "FormCell", for: indexPath) as? FormCell)!
//        cell.configure(withViewModel: formViewModel, indexPath: indexPath)
//        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
