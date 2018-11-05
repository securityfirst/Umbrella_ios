//
//  AccountViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var accountViewModel: AccountViewModel = {
        let accountViewModel = AccountViewModel()
        return accountViewModel
    }()
    
    @IBOutlet weak var accountTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Account".localized()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension AccountViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accountViewModel.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: AccountCell = (tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as? AccountCell)!
        
        cell.configure(withViewModel: self.accountViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AccountViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.accountViewModel.items[indexPath.row]
        
        switch item.type {
            
        case AccountItem.settings: break
        case AccountItem.mask: break
        case AccountItem.setPassword: break
        case AccountItem.switchRepo:
            let app = (UIApplication.shared.delegate as? AppDelegate)!
            app.show()
            
        default:
            break
        }
    }
}
