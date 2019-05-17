//
//  SegmentViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import WebKit

class SegmentViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var segmentViewModel: SegmentViewModel = {
        let segmentViewModel = SegmentViewModel()
        return segmentViewModel
    }()
    var menuView: BTNavigationDropdownMenu?
    var wkWebView: WKWebView!
    var fileNameShare: String = ""
    
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentCollectionView: UICollectionView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }
        
        if self.segmentViewModel.subCategory != nil {
            self.title = "\(self.segmentViewModel.subCategory!.name!) \(self.segmentViewModel.difficulty!.name!)"
        } else {
            self.title = self.segmentViewModel.difficulty?.name
        }
        
        self.emptyLabel.text = "You do not have any Segment yet.".localized()
        self.checkIfEmptyList()

        self.segmentViewModel.updateFavouriteSegment()
        self.segmentCollectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.segmentViewModel.difficulties.count > 1 {
            var categoryName = ""
            if self.segmentViewModel.subCategory != nil {
                categoryName = self.segmentViewModel.subCategory!.name!
            }
            var items: [String] = [String]()
            for difficulty in segmentViewModel.difficulties {
                items.append("\(categoryName) \(difficulty.name ?? "")")
            }
            
            self.menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title(self.title ?? ""), items: items)
            
            self.menuView?.arrowTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.menuView?.checkMarkImage = #imageLiteral(resourceName: "iconCheckmark")
            let font = UIFont(name: "Roboto-Bold", size: 15)
            self.menuView?.navigationBarTitleFont = font
            self.menuView?.cellTextLabelFont = font
            self.navigationItem.titleView = self.menuView
            
            self.menuView?.didSelectItemAtIndexHandler = { indexPath in
                self.segmentCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                self.segmentViewModel.difficulty = self.segmentViewModel.difficulties[indexPath]
                self.segmentCollectionView.reloadData()
                
                if let difficulty = self.segmentViewModel.difficulty {
                    self.title = "\(categoryName) \(difficulty.name ?? "")"
                    let difficultyRule = DifficultyRule(categoryId: difficulty.parent, difficultyId: difficulty.id)
                    self.segmentViewModel.insert(difficultyRule)
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.menuView?.hide()
    }
    
    //
    // MARK: - UIStoryboardSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if segue.identifier == "reviewLessonSegue" {
            
            let reviewLessonViewController = (segue.destination as? ReviewLessonViewController)!
            
            let dictionary = (sender as? [String: Any])!
            reviewLessonViewController.reviewLessonViewModel.segments = (dictionary["segments"] as? [Segment])!
            reviewLessonViewController.reviewLessonViewModel.checkLists = (dictionary["checkLists"] as? [CheckList])!
            reviewLessonViewController.reviewLessonViewModel.category = (dictionary["category"] as? Category)!
            reviewLessonViewController.reviewLessonViewModel.selected = dictionary["selected"] 
        }
    }
    
    //
    // MARK: - Functions
    
    /// Check if empty List
    func checkIfEmptyList() {
        self.segmentCollectionView.isHidden = self.segmentViewModel.difficulty?.segments.count == 0
        self.searchBar.isHidden = self.segmentCollectionView.isHidden
    }
}

//
// MARK: - UICollectionViewDelegate
extension SegmentViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var selected: (Any)? = nil
        if indexPath.section == 0 {
            let segment = self.segmentViewModel.getSegments()[indexPath.row]
            selected = segment
        } else if indexPath.section == 1 {
            let checklist = self.segmentViewModel.difficulty?.checkLists[indexPath.row]
            selected = checklist!
        }
        
        self.performSegue(withIdentifier: "reviewLessonSegue", sender: ["segments": self.segmentViewModel.getSegments(), "checkLists": self.segmentViewModel.difficulty?.checkLists ?? [CheckList](), "category": self.segmentViewModel.difficulty!, "selected": selected])
    }
}

//
// MARK: - UICollectionViewDataSource
extension SegmentViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.segmentViewModel.getSegments().count
        } else if section == 1, let difficulty = self.segmentViewModel.difficulty {
            return difficulty.checkLists.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentCell",
                                                           for: indexPath) as? SegmentCell)!
            cell.configure(withViewModel: self.segmentViewModel, indexPath: indexPath)
            cell.delegate = self
            return cell
        } else {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "CheckListCell",
                                                           for: indexPath) as? CheckListCell)!
            cell.configure(withViewModel: self.segmentViewModel, indexPath: indexPath)
            cell.delegate = self
            return cell
        }
    }
}

//
// MARK: - UICollectionViewDelegateFlowLayout
extension SegmentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width/2-15, height: 187)
        } else {
            return CGSize(width: UIScreen.main.bounds.width-22, height: 132)
        }
    }
}

//
// MARK: - SegmentCellDelegate
extension SegmentViewController: SegmentCellDelegate {
    
    func favouriteSegment(cell: SegmentCell) {
        
        let indexPath = self.segmentCollectionView.indexPath(for: cell)
        
        if let  indexPath = indexPath {
            let segment = self.segmentViewModel.getSegments()[indexPath.row]
            segment.favourite = !segment.favourite
            
            if segment.favourite {
                var categoryId = self.segmentViewModel.difficulty!.parent
                var difficultyId = self.segmentViewModel.difficulty!.id
                
                if self.segmentViewModel.difficulty!.parent == 0 {
                    categoryId = self.segmentViewModel.difficulty!.id
                    difficultyId = 0
                }
                let favouriteSegment = FavouriteLesson(categoryId: categoryId, difficultyId: difficultyId, segmentId: segment.id)
                self.segmentViewModel.insert(favouriteSegment)
            } else {
                self.segmentViewModel.remove(segment.id)
                
                if self.segmentViewModel.difficulty?.name == "Favourites".localized() {
                    self.segmentViewModel.difficulty?.segments.remove(at: indexPath.row)
                }
            }
            
            if self.segmentViewModel.difficulty?.name == "Favourites".localized() {
                self.checkIfEmptyList()
                self.segmentCollectionView.reloadData()
            } else {
                self.segmentCollectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
    func shareSegment(cell: SegmentCell) {
        let indexPath = self.segmentCollectionView.indexPath(for: cell)
        
        if let  indexPath = indexPath {
            let segment = self.segmentViewModel.getSegments()[indexPath.row]
            
            if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                var path = documentsPathURL.absoluteString
                path.removeLast()
                path = path.replacingOccurrences(of: "file://", with: "")
                segment.content = segment.content?.replacingOccurrences(of: "#DOCUMENTS", with: path)
                
                self.fileNameShare = segment.name!.components(separatedBy: .whitespacesAndNewlines).joined()
                let html = HTML(nameFile: "\(self.fileNameShare).html", content: segment.content!)
                html.prepareHtmlWithStyle()
                let export = Export(html)
                let url = export.makeExport()
                
                self.wkWebView = WKWebView(frame: self.view.bounds)
                self.wkWebView.navigationDelegate = self
                self.wkWebView.loadFileURL(url, allowingReadAccessTo: documentsPathURL)
            }
        }
    }
}

//
// MARK: - SegmentCellDelegate
extension SegmentViewController: ChecklistCellDelegate {
    
    func favouriteChecklist(cell: CheckListCell) {
        
        let indexPath = self.segmentCollectionView.indexPath(for: cell)
        
        if let indexPath = indexPath, indexPath.section == 1 {
            
            let checklist = self.segmentViewModel.difficulty?.checkLists[indexPath.row]
            
            if let checklist = checklist {
                checklist.favourite = !checklist.favourite
                
                let languageName: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
                let language = UmbrellaDatabase.languagesStatic.filter { $0.name == languageName }.first
                let checklistChecked = ChecklistChecked(subCategoryName: self.segmentViewModel.subCategory!.name ?? "", subCategoryId: self.segmentViewModel.subCategory!.id, difficultyId: self.segmentViewModel.difficulty!.id, checklistId: checklist.id, languageId:language!.id)
                checklistChecked.totalItemsChecklist = checklist.countItemCheck()
                if checklist.favourite {
                    let favouriteSegment = FavouriteLesson(categoryId: self.segmentViewModel.difficulty!.parent, difficultyId: self.segmentViewModel.difficulty!.id, segmentId: -1)
                    self.segmentViewModel.insert(favouriteSegment)
                    self.segmentViewModel.insert(checklistChecked)
                } else {
                    
                    self.segmentViewModel.remove(checklistChecked)
                    self.segmentViewModel.removeFavouriteChecklist(self.segmentViewModel.difficulty!.parent, difficultyId: self.segmentViewModel.difficulty!.id)
                }
            }
            
            self.segmentCollectionView.reloadItems(at: [indexPath])
        }
    }
    
    func shareChecklist(cell: CheckListCell) {
        let indexPath = self.segmentCollectionView.indexPath(for: cell)
        var objectsToShare:[Any] = [Any]()
        
        if let indexPath = indexPath, indexPath.section == 1 {
            
            let checklist = self.segmentViewModel.difficulty?.checkLists[indexPath.row]
            
            if let checklist = checklist {
                var content: String = ""
                
                content += """
                <html>
                <head>
                <meta charset="UTF-8"> \n
                """
                content += "<title>\(self.segmentViewModel.difficulty!.name ?? "") - Checklist</title> \n"
                content += "</head> \n"
                content += "<body style=\"display:block;width:100%;\"> \n"
                content += "<h1>Checklist</h1> \n"
                
                for checkItem in checklist.items {
                    content += "<label><input type=\"checkbox\"\(checkItem.checked ? "checked" : "") readonly onclick=\"return false;\">\(checkItem.name)</label><br> \n"
                }
                
                content += """
                </form>
                </body>
                </html>
                """
                
                UIAlertController.alertSheet(title: "", message: "Choose the format.".localized(), buttons: ["HTML", "PDF"], dismiss: { (option) in
                    
                    if option == 0 {
                        // HTML
                        let html = HTML(nameFile: "Checklist.html", content: content)
                        let export = Export(html)
                        let url = export.makeExport()
                        objectsToShare = [url]
                    } else if option == 1 {
                        //PDF
                        let pdf = PDF(nameFile: "Checklist.pdf", content: content)
                        let export = Export(pdf)
                        let url = export.makeExport()
                        objectsToShare = [url]
                    }
                    
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    
                    //New Excluded Activities Code
                    activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.copyToPasteboard]
                    
                    activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
                        if !completed {
                            // User canceled
                            return
                        }
                    }
                    
                    self.present(activityVC, animated: true, completion: nil)
                }, cancel: {
                    print("cancel")
                })
            }
        }
    }
}

//
// MARK: - UISearchBarDelegate
extension SegmentViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        if let text = searchBar.text {
            self.segmentViewModel.termSearch = text
            self.segmentViewModel.updateFavouriteSegment()
            self.segmentCollectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.segmentViewModel.termSearch = ""
            self.segmentViewModel.updateFavouriteSegment()
            self.segmentCollectionView.reloadData()
            
            delay(0.25) {
                self.view.endEditing(true)
            }
        }
    }
}

extension SegmentViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        var objectsToShare:[Any] = [Any]()
        guard let pdfURL = FileManager.default.documentsURL?.appendingPathComponent("\(self.fileNameShare).pdf") else { return }
        let renderer = HTML2PDFRenderer()
        renderer.render(webView: webView, toPDF: pdfURL, paperSize: .a4)
        objectsToShare = [pdfURL]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        //New Excluded Activities Code
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.copyToPasteboard]
        
        activityVC.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if !completed {
                // User canceled
                return
            }
            // User completed activity
        }
        
        self.present(activityVC, animated: true, completion: nil)
    }
}
