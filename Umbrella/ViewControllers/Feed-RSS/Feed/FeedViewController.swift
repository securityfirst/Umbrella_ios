//
//  FeedViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import FeedKit
import CoreLocation
import UserNotifications
import Localize_Swift

class FeedViewController: UIViewController {
    
    //
    // MARK: - Properties
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var feedView: FeedView!
    @IBOutlet weak var rssView: RssView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var sourceLegLabel: UILabel!
    @IBOutlet weak var setYourFeedLegLabel: UILabel!
    @IBOutlet weak var intervalLegLabel: UILabel!
    @IBOutlet weak var locationLegLabel: UILabel!
    @IBOutlet weak var setupScrollView: UIScrollView!
    @IBOutlet weak var locationChosenView: UmbrellaView!
    @IBOutlet weak var locationChosenLabel: UILabel!
    @IBOutlet weak var changeLocationButton: UIButton!
    @IBOutlet weak var locationViewLegLabel: UILabel!
    @IBOutlet weak var setYourFeedLabel: UILabel!
    @IBOutlet weak var setNowLabel: UILabel!
    @IBOutlet weak var securityFeedToLabel: UILabel!
    @IBOutlet weak var emptyDisplayLebLabel: UILabel!
    @IBOutlet weak var emptyChangeLocationLabel: UIButton!
    @IBOutlet weak var intervalLabel: UILabel!
    @IBOutlet weak var setIntervalLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var setLocationLabel: UILabel!
    @IBOutlet weak var securityFeedSourcesLabel: UILabel!
    
    @IBOutlet weak var setSourcesLabel: UILabel!
    
    var loadingViewController: LoadingViewController!
    var loginViewController: LoginViewController!
    var tourViewController: TourViewController!
    var releaseNoteViewController: ReleaseNoteViewController!
    var pathwayViewController: PathwayViewController!
    var stepLocation: Bool = false
    var stepSources: Bool = false
    var isStartingSetup: Bool = false
    var continueWizard: Bool = false
    var intervalTimer = Timer()
    var sourceLegend = ""
    var intervalSet = "" {
        didSet {
            if intervalSet == "-1" {
                self.feedView.intervalLabel.text = "Manually".localized()
            } else {
                self.feedView.intervalLabel.text = "\(intervalSet.count == 0 ? "30" : intervalSet) min"
            }
            checkState()
        }
    }
    
    var locationSet = (city: "", country: "", countryCode: "") {
        didSet {
            self.feedView.locationLabel.text = locationSet.country
            checkState()
        }
    }
    
    var sourceSet = [Int]() {
        didSet {
            if sourceSet.count == 0 {
                self.sourceLegLabel.text = self.sourceLegend
                self.sourceLegLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                checkState()
                return
            }
            
            var stringBuffer = ""
            
            for index in sourceSet {
                let source = Sources.list.filter { $0.code == index}.first
                if let source = source {
                    stringBuffer.append("- \(source.name)\n")
                }
                self.sourceLegLabel.text = stringBuffer
                self.sourceLegLabel.textColor = #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1)
            }
            checkState()
        }
    }
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Feeds".localized()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
           segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
           segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
        } else {
           segmentedControl.tintColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
        }
        
        // Show release note just first time.
        // I'm checking whether the version and build are different, if yes, show release note.
        var showReleaseNote = false
        let releaseNoteVersion = UserDefaults.standard.object(forKey: "ReleaseNote") as? String
        if releaseNoteVersion == nil || releaseNoteVersion != version() {
            UserDefaults.standard.set(version(), forKey: "ReleaseNote")
            showReleaseNote = true
        }

        updateLanguage()
        
        self.segmentedControl.setTitle("Feeds".localized(), forSegmentAt: 0)
        self.segmentedControl.setTitle("RSS".localized(), forSegmentAt: 1)
        
        self.sourceLegend = self.sourceLegLabel.text ?? ""
        
        addBarButton.isEnabled = false
        addBarButton.tintColor = UIColor.clear
        addBarButton.accessibilityElementsHidden = true
        addBarButton.isAccessibilityElement = false
        
        feedView.delegate = self
        rssView.delegate = self
        
        let isAcceptedTerm = UserDefaults.standard.bool(forKey: "acceptTerm")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        self.releaseNoteViewController = (storyboard.instantiateViewController(withIdentifier: "ReleaseNoteViewController") as? ReleaseNoteViewController)!
        
        if isAcceptedTerm {
            let passwordCustom: Bool = UserDefaults.standard.object(forKey: "passwordCustom") as? Bool ?? false
            if passwordCustom {
                let storyboard = UIStoryboard(name: "Account", bundle: Bundle.main)
                self.loginViewController = (storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController)!
                UIApplication.shared.keyWindow?.rootViewController!.add(self.loginViewController)
            } else {
                let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
                UIApplication.shared.keyWindow?.addSubview(controller.view)
                controller.loadTent {
                    print("Finished load tent")
                    let showPathwayFirstTime = self.showPathway()
                    self.showReleaseNote(show: showReleaseNote, showPathway: showPathwayFirstTime)
                }
            }
        } else {
            self.tourViewController = (storyboard.instantiateViewController(withIdentifier: "TourViewController") as? TourViewController)!
            UIApplication.shared.keyWindow?.rootViewController!.add(self.tourViewController)
            
            self.loadingViewController = LoadingViewController()
            self.loadingViewController.startingTheUseTheContent()

            self.tourViewController.didAcceptTerm = {
                let showPathwayFirstTime = self.showPathway()
                self.showReleaseNote(show: showReleaseNote, showPathway: showPathwayFirstTime)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(FeedViewController.updateLocation(notification:)), name: Notification.Name("UpdateLocation"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FeedViewController.updateInterval(notification:)), name: Notification.Name("UpdateInterval"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FeedViewController.updateSources(notification:)), name: Notification.Name("UpdateSources"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FeedViewController.continueWizard(notification:)), name: Notification.Name("ContinueWizard"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FeedViewController.resetRepository(notification:)), name: Notification.Name("ResetRepository"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FeedViewController.updateFeedInBackground), name: Notification.Name("UpdateFeed"), object: nil)
        
        self.locationChosenView.isHidden = true
        self.feedView.activityIndicatorView.isHidden = true
        self.feedView.emptyView.isHidden = true
        
        loadSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.isStartingSetup && self.continueWizard {
            checkSetupWizard()
        }
        
        self.continueWizard = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - UIStoryboardSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rssSegue" {
            let destination = (segue.destination as? ListRssViewController)!
            let rss = (sender as? RSSFeed)!
            
            if let items = rss.items {
                destination.listRssViewModel.items = items
            }
        } else if segue.identifier == "webSegue" {
            let destination = (segue.destination as? WebViewController)!
            let feedItem = (sender as? FeedItem)!
            
            destination.webViewModel.link = feedItem.url
            destination.webViewModel.title = feedItem.title
        }
    }
    
    //
    // MARK: - Functions
    
    func showReleaseNote(show: Bool, showPathway: Bool) {
        if !showPathway {
            self.pathwayViewController.didClosePathway = {
                if show {
                    UIApplication.shared.keyWindow?.addSubview(self.releaseNoteViewController.view)
                }
            }
        } else {
            if show {
                UIApplication.shared.keyWindow?.addSubview(self.releaseNoteViewController.view)
            }
        }
    }
    
    /// Show Pathway screen
    ///
    /// - Returns: Bool
    func showPathway() -> Bool {
        let showPathway = UserDefaults.standard.bool(forKey: "ShowPathway")
        if !showPathway {
            UserDefaults.standard.set(true, forKey: "ShowPathway")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.pathwayViewController = (storyboard.instantiateViewController(withIdentifier: "PathwayViewController") as? PathwayViewController)!
            self.pathwayViewController.modalPresentationStyle = .fullScreen
            self.present(self.pathwayViewController, animated: true, completion: nil)
            return false
        } else {
            return true
        }
    }
    
    /// Get Version and build from app
    ///
    /// - Returns: String
    func version() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = (dictionary["CFBundleShortVersionString"] as? String)!
        let build = (dictionary["CFBundleVersion"] as? String)!
        return "\(version).\(build)"
    }
    
    /// Update text when language changed
    @objc func updateLanguage() {
        self.title = "Feeds".localized()

        self.feedView.emptyLabel.text = "There no Feed".localized()
        
        // Location
        self.changeLocationButton.setTitle("CHANGE FEED SETTINGS".localized(), for: .normal)
        
        self.locationViewLegLabel.text = "Location:".localized()
        self.setYourFeedLabel.text = "Set your Feed".localized()
        self.setNowLabel.text = "SET NOW".localized()
        
        self.securityFeedToLabel.text = "Security feed set to:".localized()
        self.emptyDisplayLebLabel.text = "There are no events to display for your location. We’ll display them when they will occur. Pull to refresh to check again.".localized()
        self.emptyChangeLocationLabel.setTitle("CHANGE FEED SETTINGS".localized(), for: .normal)
        
        self.intervalLabel.text = "Interval".localized()
        self.setIntervalLabel.text = "SET".localized()
        self.locationLabel.text = "Location".localized()
        self.setLocationLabel.text = "SET".localized()
        self.securityFeedSourcesLabel.text = "Security Feed Sources".localized()
        
        self.setSourcesLabel.text = "SET".localized()
        
        self.segmentedControl.setTitle("Feeds".localized(), forSegmentAt: 0)
        self.segmentedControl.setTitle("RSS".localized(), forSegmentAt: 1)
        self.setYourFeedLegLabel.text = "You haven’t set the location and the sources for the feed yet. You have to do that to get the latest security news for your country. You can change it anytime later in the settings.".localized()
        self.intervalLegLabel.text = "Set how often you want Umbrella to check for the latest security news.".localized()
        self.locationLegLabel.text = "We do not store your location for longer than necessary. Feed providers do not know you are receiving data from them.".localized()
        self.sourceLegLabel.text = "Set the sources that you want updates from. The feed sources cannot see that you are requesting information from them.".localized()
        
        self.sourceLegend = self.sourceLegLabel.text ?? ""
        
        loadSetup()
        
        let language: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        // Arabic(ar) or Persian Farsi(fa)
        if language == "ar" || language == "fa" {
            self.setYourFeedLabel.textAlignment = .right
            self.setYourFeedLegLabel.textAlignment = .right
            self.intervalLabel.textAlignment = .right
            self.intervalLegLabel.textAlignment = .right
            self.locationLabel.textAlignment = .right
            self.locationLegLabel.textAlignment = .right
            self.securityFeedSourcesLabel.textAlignment = .right
            self.sourceLegLabel.textAlignment = .right
        } else {
            self.setYourFeedLabel.textAlignment = .left
            self.setYourFeedLegLabel.textAlignment = .left
            self.intervalLabel.textAlignment = .left
            self.intervalLegLabel.textAlignment = .left
            self.locationLabel.textAlignment = .left
            self.locationLegLabel.textAlignment = .left
            self.securityFeedSourcesLabel.textAlignment = .left
            self.sourceLegLabel.textAlignment = .left
        }
    }
    
    /// Refresh repository
    ///
    /// - Parameter sender: UIBarButtonItem
    @objc func refreshRepo(_ sender: UIBarButtonItem) {
        
        let sqlManager = SQLManager(databaseName: Database.name, password: Database.password)
        let umbrellaDatabase = UmbrellaDatabase(sqlProtocol: sqlManager)
        _ = umbrellaDatabase.dropTables()
        
        let repository = (UserDefaults.standard.object(forKey: "repository") as? String)!
        let gitManager = GitManager(url: URL(string: repository)!, pathDirectory: .documentDirectory)
        
        do {
            try gitManager.deleteCloneInFolder(pathDirectory: .documentDirectory)
            
            NotificationCenter.default.post(name: Notification.Name("ResetRepository"), object: nil)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
            UIApplication.shared.keyWindow?.addSubview(controller.view)
            controller.loadTent {
                print("Finished load tent")
            }
        } catch {
            print(error)
        }
    }
    
    /// Check the workflow of the setup Wizard
    func checkSetupWizard() {
        
        if !stepLocation {
            self.performSegue(withIdentifier: "locationSegue", sender: nil)
        } else if !stepSources {
            self.performSegue(withIdentifier: "sourcesSegue", sender: nil)
        }
    }
    
    /// Update feed in background
    @objc func updateFeedInBackground() {
        if intervalSet.count > 0 && locationSet.countryCode.count > 0 && sourceSet.count > 0 {
            self.feedView.feedViewModel.requestFeedInBackground(completion: {
                DispatchQueue.main.async {
                    
                    if self.feedView.feedViewModel.feedItems.count == 0 {
                        self.feedView.emptyView.isHidden = false
                        self.feedView.feedTableView.isHidden = false
                        self.feedView.activityIndicatorView.isHidden = true
                        self.feedView.topConstraint.constant = 100
                        return
                    }
                    
                    let showUpdateAsNotification = UserDefaults.standard.object(forKey: "showUpdateAsNotification") as? Bool
                    
                    if showUpdateAsNotification ?? false {
                        
                        let notification = UNMutableNotificationContent()
                        notification.title = self.feedView.feedViewModel.feedItems.count == 1 ? self.feedView.feedViewModel.feedItems[0].title : "Dashboard".localized()
                        notification.body = self.feedView.feedViewModel.feedItems.count == 1 ? self.feedView.feedViewModel.feedItems[0].description : "\(self.feedView.feedViewModel.feedItems.count) \("new customFeeds.".localized()))"
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                        let request = UNNotificationRequest(identifier: "umbrella", content: notification, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request) { error in
                            print(error as Any)
                        }
                    }
                    
                    self.feedView.topConstraint.constant = 20
                    
                    self.feedView.emptyView.isHidden = true
                    self.feedView.feedTableView.isHidden = false
                    self.locationChosenView.isHidden = false
                    self.feedView.activityIndicatorView.isHidden = true
                    self.feedView.feedTableView.reloadData()
                    self.feedView.feedTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
                }
            }, failure: { (error) in
                DispatchQueue.main.async {
                    self.feedView.emptyView.isHidden = false
                    self.feedView.feedTableView.isHidden = false
                    self.feedView.activityIndicatorView.isHidden = true
                    self.feedView.topConstraint.constant = 100
                }
            })
        }
    }
    
    /// Check the state
    func checkState() {
        if intervalSet.count > 0 && locationSet.countryCode.count > 0 && sourceSet.count > 0 {
            self.showFeedList()
        } else {
            self.closeFeedList()
        }
    }
    
    /// Show Feed List
    func showFeedList() {
        
        if intervalTimer.isValid {
            intervalTimer.invalidate()
        }
        
        if let interval = Double(intervalSet) {
            
            if interval != -1 {
                intervalTimer = Timer.scheduledTimer(timeInterval: interval * 60.0, target: self, selector: #selector(self.refreshFeed), userInfo: index, repeats: true)
            }
        }
        
        self.setupScrollView.isHidden = true
        self.feedView.feedTableView.isHidden = true
        self.locationChosenView.isHidden = true
        self.feedView.activityIndicatorView.isHidden = false
        self.locationChosenLabel.text = locationSet.country
        self.feedView.emptyCountryLabel.text = locationSet.country
        self.feedView.feedViewModel.location = locationSet.countryCode.lowercased()
        self.feedView.feedViewModel.sources = sourceSet
        self.feedView.feedViewModel.requestFeed(completion: {
            DispatchQueue.main.async {
                
                if self.feedView.feedViewModel.feedItems.count == 0 {
                    self.feedView.emptyView.isHidden = false
                    self.feedView.feedTableView.isHidden = false
                    self.feedView.activityIndicatorView.isHidden = true
                    self.feedView.topConstraint.constant = 100
                    self.feedView.feedTableView.reloadData()
                    return
                }
                
                self.feedView.topConstraint.constant = 20
                
                self.feedView.emptyView.isHidden = true
                self.feedView.feedTableView.isHidden = false
                self.locationChosenView.isHidden = false
                self.feedView.activityIndicatorView.isHidden = true
                self.feedView.feedTableView.reloadData()
                
                if self.feedView.feedViewModel.feedItems.count > 0 {
                    self.feedView.feedTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
                }
            }
        }, failure: { (error) in
            DispatchQueue.main.async {
                self.feedView.emptyView.isHidden = false
                self.feedView.feedTableView.isHidden = false
                self.feedView.activityIndicatorView.isHidden = true
                self.feedView.topConstraint.constant = 100
            }
        })
    }
    
    /// Close Feed list
    func closeFeedList() {
        self.setupScrollView.isHidden = false
        self.feedView.feedTableView.isHidden = true
        self.locationChosenView.isHidden = true
        self.feedView.emptyView.isHidden = true
    }
    
    /// Load setup
    func loadSetup() {
        
        let interval = UserDefaults.standard.object(forKey: "Interval") as? String
        let locationCity = UserDefaults.standard.object(forKey: "LocationCity") as? String
        let locationCountry = UserDefaults.standard.object(forKey: "LocationCountry") as? String
        let locationCountryCode = UserDefaults.standard.object(forKey: "LocationCountryCode") as? String
        let sources = UserDefaults.standard.object(forKey: "Sources") as? [Int]
        
        if let interval = interval {
            intervalSet = interval.count == 0 ? "30" : interval
        } else {
            intervalSet = "30"
        }
        
        if let locationCity = locationCity, let locationCountry = locationCountry, let locationCountryCode = locationCountryCode {
            locationSet = (city: locationCity, country: locationCountry, countryCode: locationCountryCode)
        }
        
        if let sources = sources {
            sourceSet = sources
        }
    }
    
    /// Reset Setup
    func resetSetup() {
        UserDefaults.standard.set([], forKey: "Sources")
        UserDefaults.standard.set("", forKey: "Interval")
        UserDefaults.standard.set("", forKey: "LocationCity")
        UserDefaults.standard.set("", forKey: "LocationCountry")
        UserDefaults.standard.set("", forKey: "LocationCountryCode")
        
        isStartingSetup = false
        stepLocation = false
        stepSources = false
        
        if intervalTimer.isValid {
            intervalTimer.invalidate()
        }
        
        locationSet = (city: "", country: "", countryCode: "")
        sourceSet = []
        intervalSet = "30"
        
        self.feedView.feedViewModel.feedItems.removeAll()
        self.feedView.feedTableView.reloadData()
    }
    
    /// Reset Demo
    ///
    /// - Parameter notification: NSNotification
    @objc func resetRepository(notification: NSNotification) {
        resetSetup()
    }
    
    /// Update Location
    ///
    /// - Parameter notification: NSNotification
    @objc func updateLocation(notification: NSNotification) {
        let userInfo = notification.userInfo
        
        if let placeMark = userInfo?["location"] as? (String, String, String) {
            locationSet = placeMark
            stepLocation = true
        }
    }
    
    /// Update Interval
    ///
    /// - Parameter notification: NSNotification
    @objc func updateInterval(notification: NSNotification) {
        let userInfo = notification.userInfo
        
        if let interval = userInfo?["interval"] as? String {
            intervalSet = interval
        }
    }
    
    /// Update Sources
    ///
    /// - Parameter notification: NSNotification
    @objc func updateSources(notification: NSNotification) {
        let userInfo = notification.userInfo
        
        if let sources = userInfo?["sources"] as? [Int] {
            sourceSet = sources
            stepSources = true
        }
    }
    
    /// Continue Wizard
    ///
    /// - Parameter notification: NSNotification
    @objc func continueWizard(notification: NSNotification) {
        continueWizard = true
    }
    
    /// Refresh Feed
    fileprivate func refresFeed() {
        self.feedView.feedViewModel.requestFeed(completion: {
            DispatchQueue.main.async {
                self.feedView.refreshControl.endRefreshing()
                if self.feedView.feedViewModel.feedItems.count == 0 {
                    self.feedView.emptyView.isHidden = false
                    self.feedView.activityIndicatorView.isHidden = true
                    return
                }
                
                self.feedView.emptyView.isHidden = true
                self.feedView.feedTableView.isHidden = false
                self.locationChosenView.isHidden = false
                self.feedView.activityIndicatorView.isHidden = true
                self.feedView.feedTableView.reloadData()
            }
        }, failure: { (error) in
            DispatchQueue.main.async {
                self.feedView.refreshControl.endRefreshing()
                self.feedView.emptyView.isHidden = false
                self.feedView.feedTableView.isHidden = false
                self.feedView.activityIndicatorView.isHidden = true
            }
        })
    }
    
    /// Validate if there is an url valid
    ///
    /// - Parameter urlString: String
    /// - Returns: Bool
    func validateUrl (urlString: String) -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        
        //        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
    }
    
    /// Show rss error
    func showRssError() {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow!.makeToast("There was an error when attempting to create the RSS feed. Please make sure you're using the correct address and try again.".localized(), duration: 6.0, position: .center)
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func choiceAction(_ sender: UISegmentedControl) {
        self.feedView.isHidden = sender.selectedSegmentIndex == 1
        self.rssView.isHidden = sender.selectedSegmentIndex == 0
        
        addBarButton.accessibilityElementsHidden = self.feedView.isHidden
        addBarButton.isAccessibilityElement = !self.rssView.isHidden
        addBarButton.isEnabled = !self.rssView.isHidden
        addBarButton.tintColor = addBarButton.isEnabled ? #colorLiteral(red: 0.4588235294, green: 0.4588235294, blue: 0.4588235294, alpha: 1) : UIColor.clear
    }
    
    @IBAction func addAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Feed Sources".localized(), message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "http://"
            textField.keyboardType = UIKeyboardType.URL
        }
        let saveAction = UIAlertAction(title: "Save".localized(), style: UIAlertAction.Style.default, handler: { _ in
            let firstTextField = alertController.textFields![0] as UITextField
            
            if let count = firstTextField.text?.count, count > 0, self.validateUrl(urlString: firstTextField.text!) {
                
                let rssItem = RssItem(url: firstTextField.text!, isCustom: 1)
                self.rssView.rssViewModel.loadSpecifyRSS(rssItem: rssItem, completion: {
                    self.rssView.rssViewModel.insert(firstTextField.text!)
                    self.rssView.rssTableView.reloadData()
                    self.rssView.rssTableView.scrollToBottomRow()
                }, failure: { error in
                    self.showRssError()
                })
            } else {
                self.showRssError()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel".localized(), style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

//
// MARK: - RssViewDelegate
extension FeedViewController: RssViewDelegate {
    func openRss(rss: RSSFeed) {
        self.performSegue(withIdentifier: "rssSegue", sender: rss)
    }
}

//
// MARK: - FeedViewDelegate
extension FeedViewController: FeedViewDelegate {
    func choiceLocation() {
        self.performSegue(withIdentifier: "locationSegue", sender: nil)
    }
    
    func choiceInterval() {
        self.performSegue(withIdentifier: "intervalSegue", sender: nil)
    }
    
    func choiceSource() {
        self.performSegue(withIdentifier: "sourcesSegue", sender: nil)
    }
    
    func resetFeed() {
        self.resetSetup()
        self.closeFeedList()
    }
    
    @objc func refreshFeed() {
        refresFeed()
    }
    
    func openWebView(item: FeedItem) {
        self.performSegue(withIdentifier: "webSegue", sender: item)
    }
    
    func starSetupFeed() {
        isStartingSetup = true
        continueWizard = false
        checkSetupWizard()
    }
}
