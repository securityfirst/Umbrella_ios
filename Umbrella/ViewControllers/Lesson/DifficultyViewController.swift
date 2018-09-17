//
//  DifficultyViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 14/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController {

    //
    // MARK: - Properties
    lazy var difficultyViewModel: DifficultyViewModel = {
        let difficultyViewModel = DifficultyViewModel()
        return difficultyViewModel
    }()
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = self.difficultyViewModel.categoryParent?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //
    // MARK: - UIStoryboardSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segmentSegue" {
        }
    }
}

// MARK: - UITableViewDataSource
extension DifficultyViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.difficultyViewModel.difficulties.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DifficultyCell = (tableView.dequeueReusableCell(withIdentifier: "DifficultyCell", for: indexPath) as? DifficultyCell)!
        
        cell.configure(withViewModel: self.difficultyViewModel, indexPath: indexPath)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DifficultyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 164.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "segmentSegue", sender: nil)
    }
}
