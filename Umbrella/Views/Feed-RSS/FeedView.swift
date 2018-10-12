//
//  FeedView.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

protocol FeedViewDelegate: class {
    func choiceLocation()
    func choiceInterval()
    func choiceSource()
}

class FeedView: UIView {

    //
    // MARK: - Properties
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    weak var delegate: FeedViewDelegate!
    
    //
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.emptyLabel.text = "There no Feed".localized()
    }
    
    //
    // MARK: - Actions
    
    @IBAction func setYourFeedAction(_ sender: Any) {
        print("Set your Feed")
    }
    
    @IBAction func intervalAction(_ sender: Any) {
        self.delegate?.choiceInterval()
    }
    
    @IBAction func locationAction(_ sender: Any) {
        self.delegate?.choiceLocation()
    }
    
    @IBAction func securityFeedAction(_ sender: Any) {
        self.delegate?.choiceSource()
    }
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
        let cell: FeedCell = (tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell)!
//        cell.configure(withViewModel: formViewModel, indexPath: indexPath)
//        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
