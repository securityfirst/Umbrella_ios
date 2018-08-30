//
//  ListRssViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 29/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class ListRssViewController: UIViewController {
    
    //
    // MARK: - Properties
    var rssModeView: Int = 0
    @IBOutlet weak var rssModeViewButtonItem: UIBarButtonItem!
    @IBOutlet weak var listRssTableView: UITableView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 = UIBarButtonItem(image: #imageLiteral(resourceName: "rssCardChoice"), style: .plain, target: self, action: #selector(self.rssModeViewAction(_:)))
        button1.tintColor = #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        self.navigationItem.rightBarButtonItem  = button1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    // MARK: - Actions
    
    @IBAction func rssModeViewAction(_ sender: UIBarButtonItem) {
        if rssModeView == 0 {
            rssModeView = 1
            sender.image = #imageLiteral(resourceName: "rssListChoice")
        } else if rssModeView == 1 {
            rssModeView = 0
            sender.image = #imageLiteral(resourceName: "rssCardChoice")
        }
        
        self.listRssTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ListRssViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if rssModeView == 0 {
            let cell: ListRssCell = (tableView.dequeueReusableCell(withIdentifier: "ListRssCell", for: indexPath) as? ListRssCell)!
            //        cell.configure(withViewModel: formViewModel, indexPath: indexPath)
            //        cell.delegate = self
            return cell
        } else {
            let cell: CardRssCell = (tableView.dequeueReusableCell(withIdentifier: "CardRssCell", for: indexPath) as? CardRssCell)!
            //        cell.configure(withViewModel: formViewModel, indexPath: indexPath)
            //        cell.delegate = self
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ListRssViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
