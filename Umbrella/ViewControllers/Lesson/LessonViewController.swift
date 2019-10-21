//
//  LessonViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import Localize_Swift

class LessonViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var lessonViewModel: LessonViewModel = {
        let lessonViewModel = LessonViewModel()
        return lessonViewModel
    }()
    
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    @IBOutlet weak var lessonTableView: UITableView!
    
    var navigationItemCustom: NavigationItemCustom!
    var favouriteSegments: [Segment] = [Segment]()
    var isLoadingContent: Bool = false
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.title = "Lessons".localized()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LessonViewController.loadTent(notification:)), name: Notification.Name("UmbrellaTent"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateLanguage), name: NSNotification.Name(LCLLanguageChangeNotification), object: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        
        self.lessonTableView?.register(CategoryHeaderView.nib, forHeaderFooterViewReuseIdentifier: CategoryHeaderView.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LessonViewController.resetLessons(notification:)), name: Notification.Name("ResetRepository"), object: nil)
        
        self.loadingActivity.isHidden = false
        self.lessonTableView.isHidden = true
        
        self.navigationItemCustom = NavigationItemCustom(viewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global(qos: .default).async {
            // Update list of segment favourites
            self.favouriteSegments = self.lessonViewModel.loadFavourites()
        }
        
        if self.isLoadingContent {
            self.loadingActivity.isHidden = true
            self.lessonTableView.isHidden = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItemCustom.showItems(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItemCustom.showItems(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    @objc func updateLanguage() {
        self.title = "Lessons".localized()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    /// Reset Lessons to Demo
    ///
    /// - Parameter notification: NSNotification
    @objc func resetLessons(notification: NSNotification) {
        self.navigationController?.popToRootViewController(animated: true)
        self.lessonViewModel.sectionsCollapsed.removeAll()
        self.lessonTableView.reloadData()
    }
    
    /// Receive the tent by notification
    ///
    /// - Parameter notification: notification with umbrella
    @objc func loadTent(notification: Notification) {
        let umbrella = notification.object as? Umbrella
        self.lessonViewModel.umbrella = umbrella
        self.isLoadingContent = true
        
        if let loadingActivity = self.loadingActivity {
            loadingActivity.isHidden = true
        }
        
        if let tableview = self.lessonTableView {
            tableview.isHidden = false
            tableview.reloadData()
        }
    }
    
    /// Check if exist file in documents
    ///
    /// - Parameter file: String
    /// - Returns: Bool
    fileprivate func checkIfExistFile(file: String) -> Bool {
        
        if file.contains("/en/") {
            return true
        }
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        guard documentsUrl.count != 0 else {
            return false
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(file)
        
        if ( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            return true
        }
        
        return false
    }
    
    /// Change file string to the default language EN
    ///
    /// - Parameters:
    ///   - file: String
    fileprivate func changeFileToDefaultLanguange(file: inout String) {
        let languageCurrent: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        file = file.replacingOccurrences(of: file, with: file.replacingOccurrences(of: "/\(languageCurrent)/", with: "/en/"))
    }
    
    //
    // MARK: - UIStoryboardSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "difficultySegue" {
            let difficultyViewController = (segue.destination as? DifficultyViewController)!
            
            let category = (sender as? Category)!
            difficultyViewController.difficultyViewModel.categoryParent = category
            difficultyViewController.difficultyViewModel.difficulties = category.categories
        } else if segue.identifier == "segmentSegue" {
            let segmentViewController = (segue.destination as? SegmentViewController)!
            let subCategory = (sender as? Category)!
            
            // if the category is glossary or about does not have difficulties inside so it should show just the segments.
            if subCategory.categories.count == 0 {
                segmentViewController.segmentViewModel.difficulty = subCategory
            } else {
                segmentViewController.segmentViewModel.subCategory = subCategory
                // Check if there is difficulty rule
                let difficultyRule = DifficultyRule(categoryId: subCategory.id)
                let difficultyId = self.lessonViewModel.isExistRule(to: difficultyRule)
                
                let difficultyFilter = subCategory.categories.filter { $0.id == difficultyId }.first
                if let difficultyFilter = difficultyFilter {
                    segmentViewController.segmentViewModel.difficulty = difficultyFilter
                }
                segmentViewController.segmentViewModel.difficulties = subCategory.categories
            }
            
        } else if segue.identifier == "categoryJustSegmentsSegue" {
            let reviewLessonViewController = (segue.destination as? ReviewLessonViewController)!
            
            let dictionary = (sender as? [String: Any])!
            reviewLessonViewController.reviewLessonViewModel.segments = (dictionary["segments"] as? [Segment])!
            reviewLessonViewController.reviewLessonViewModel.checkLists = (dictionary["checkLists"] as? [CheckList])!
            reviewLessonViewController.reviewLessonViewModel.category = (dictionary["category"] as? Category)!
            reviewLessonViewController.reviewLessonViewModel.selected = dictionary["selected"]
            reviewLessonViewController.reviewLessonViewModel.isGlossary = true
        }
    }
}

//
// MARK: - UITableViewDataSource
extension LessonViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        return self.lessonViewModel.getCategories(ofLanguage: languageName).count + 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // if section == 0 so it is Favourites header
        if section == 0 {
            return 0
        }
        
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let headerItem = self.lessonViewModel.getCategories(ofLanguage: languageName)[section - 1]
        
        // if section is in array as collapsed when it should return the count of items of category
        if self.lessonViewModel.isCollapsed(section: section) {
            return headerItem.categories.count
        }
        
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CategoryCell = (tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as? CategoryCell)!
        cell.configure(withViewModel: self.lessonViewModel, indexPath: indexPath)
        
        return cell
    }
}

//
// MARK: - UITableViewDelegate
extension LessonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CategoryHeaderView.identifier) as? CategoryHeaderView {
            
            if section == 0 {
                headerView.nameLabel.text = "Favourites".localized()
                headerView.arrowImageView.isHidden = true
                headerView.iconImageView.image = #imageLiteral(resourceName: "iconFavourite")
            } else {
                let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
                let item = self.lessonViewModel.getCategories(ofLanguage: languageName)[section - 1]
                headerView.nameLabel.text = item.name
                headerView.arrowImageView.isHidden = item.categories.count == 0
                
                let path: String = (item.folderName?.components(separatedBy: "Documents").last)!
                
                if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    
                    var documents = documentsPathURL.absoluteString
                    documents.removeLast()
                    documents = documents.replacingOccurrences(of: "file://", with: "")
                    
                    var file = "\(documents)\(path)\(item.icon ?? "")"
                    
                    if !checkIfExistFile(file: file) {
                        changeFileToDefaultLanguange(file: &file)
                    }
                    headerView.iconImageView.image = UIImage(contentsOfFile: file)
                }
            }
            
            headerView.section = section
            headerView.delegate = self
            headerView.nameLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            if headerView.iconImageView.image != nil {
                headerView.iconImageView.image = headerView.iconImageView.image!.withRenderingMode(.alwaysTemplate)
            }
            
            headerView.iconImageView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            // if section is in array as collapsed when it change color of the name and icon.
            if self.lessonViewModel.isCollapsed(section: section) {
                headerView.setCollapsed(collapsed: true)
                headerView.nameLabel.textColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
                headerView.iconImageView.tintColor = #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1)
            }
            
            return headerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        let headerItem = self.lessonViewModel.getCategories(ofLanguage: languageName)[indexPath.section - 1]
        let category = headerItem.categories[indexPath.row]
        
        // Check if there is difficulty rule
        let difficultyRule = DifficultyRule(categoryId: category.id)
        let difficultyId = self.lessonViewModel.isExistRule(to: difficultyRule)
        
        // if exist go direct to segment screen
        if difficultyId != -1 || category.categories.count == 0 {
            self.performSegue(withIdentifier: "segmentSegue", sender: category)
        } else {
            self.performSegue(withIdentifier: "difficultySegue", sender: category)
        }
    }
}

//
// MARK: - CategoryHeaderViewDelegate
extension LessonViewController: CategoryHeaderViewDelegate {
    func toggleSection(header: CategoryHeaderView, section: Int) {
        let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        var collapsed = false
        if self.lessonViewModel.isCollapsed(section: section) {
            if let index = self.lessonViewModel.sectionsCollapsed.index(of: section) {
                self.lessonViewModel.sectionsCollapsed.remove(at: index)
            }
            collapsed = false
        } else if section == 0 {
            let category = Category(name: "Favourites".localized(), description: "", index: 1)
            category.segments = self.favouriteSegments
            self.performSegue(withIdentifier: "segmentSegue", sender: category)
        } else if self.lessonViewModel.getCategories(ofLanguage: languageName)[section - 1].categories.count == 0 {
            let category = self.lessonViewModel.getCategories(ofLanguage: languageName)[section - 1]
            
            if category.template == Template.glossary.rawValue {
                self.performSegue(withIdentifier: "segmentSegue", sender: category)
            } else {
                let dic = ["segments": category.segments, "checkLists": category.checkLists , "category": category, "selected": category.segments.count == 0 ? (Any).self : category.segments.first!] as [String : Any]
                self.performSegue(withIdentifier: "categoryJustSegmentsSegue", sender: dic)
            }
        } else {
            collapsed = true
            self.lessonViewModel.sectionsCollapsed.insert(section)
        }
        
        header.setCollapsed(collapsed: collapsed)
        self.lessonTableView.reloadSections([section], with: UITableView.RowAnimation.fade)
        
        // I needed to put this code because there is a bug when the tableview is in scroll then I do a collapse in some section.
        if !collapsed {
            self.lessonTableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
}

//
// MARK: - UISearchBarDelegate
extension LessonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        if let text = searchBar.text {
            self.lessonViewModel.termSearch = text
            self.lessonTableView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.lessonViewModel.termSearch = ""
            self.lessonTableView.reloadData()
            
            delay(0.25) {
                self.favouriteSegments = self.lessonViewModel.loadFavourites()
                self.view.endEditing(true)
            }
        }
    }
}

//
// MARK: - UITabBarControllerDelegate
extension LessonViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 3 {
            self.lessonViewModel.sectionsCollapsed.removeAll()
            self.lessonTableView.reloadData()
        }
    }
}
