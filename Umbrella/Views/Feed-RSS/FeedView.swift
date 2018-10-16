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
    func resetFeed()
    func refreshFeed()
    func starSetupFeed()
    func openWebView(item: FeedItem)
}

class FeedView: UIView {

    //
    // MARK: - Properties
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var emptyCountryLabel: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    weak var delegate: FeedViewDelegate!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(FeedView.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        return refreshControl
    }()

    lazy var feedViewModel: FeedViewModel = {
        let feedViewModel = FeedViewModel()
        return feedViewModel
    }()
    
    //
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.emptyLabel.text = "There no Feed".localized()
        self.feedTableView.rowHeight = UITableView.automaticDimension
        self.feedTableView.estimatedRowHeight = 200
        
        self.feedTableView.addSubview(self.refreshControl)
    }
    
    //
    // MARK: - Functions
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.delegate?.refreshFeed()
    }
    
    //
    // MARK: - Actions
    
    @IBAction func setYourFeedAction(_ sender: Any) {
        self.delegate?.starSetupFeed()
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
    
    @IBAction func resetFeedAction(_ sender: Any) {
        self.delegate?.resetFeed()
    }
}

// MARK: - UITableViewDataSource
extension FeedView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedViewModel.feedItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeedCell = (tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell)!
        cell.configure(withViewModel: feedViewModel, indexPath: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let feedItem = self.feedViewModel.feedItems[indexPath.row]
        self.delegate?.openWebView(item: feedItem)
    }
}
