//
//  ReviewLessonViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 10/10/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class ReviewLessonViewController: UIViewController {
    
    //
    // MARK: - Properties
    @IBOutlet weak var sideScrollView: SideScrollLessonView!
    @IBOutlet weak var reviewScrollView: UIScrollView!
    
    var currentPage: Int = 0
    var button: UIButton!
    var viewControllerIndexLoaded: [Int] = [Int]()
    var viewControllerLoaded: [UIViewController?]!
    var currentViewController: UIViewController!
    
    lazy var reviewLessonViewModel: ReviewLessonViewModel = {
        let reviewLessonViewModel = ReviewLessonViewModel()
        return reviewLessonViewModel
    }()
    
    lazy var pages: Int = {
        var count = 0
        if let segments = self.reviewLessonViewModel.segments?.count {
            count+=segments
        }
        
        if let checklists = self.reviewLessonViewModel.checkLists?.count {
            count+=checklists
        }
        
        return count
    }()
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllerLoaded = [UIViewController?](repeating: nil, count: self.pages)
        
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .automatic
        } else {
            // Fallback on earlier versions
        }
        
        let shareBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.shareAction(_:)))
        self.navigationItem.rightBarButtonItem = shareBarButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.reviewScrollView.contentSize = CGSize(width: self.reviewScrollView.frame.size.width * CGFloat(pages), height: self.reviewScrollView.frame.size.height)
        self.sideScrollView.dataSource = self
        self.sideScrollView.reloadData()
        
        if self.reviewLessonViewModel.selected != nil {
            self.currentPage = getIndexByObject()
        }
        
        loadContentCurrentPosition()
    }
    
    //
    // MARK: - Functions
    
    func getIndexByObject() -> Int {
        var array: [Any] = [Any]()
        
        if let segments = self.reviewLessonViewModel.segments {
            array.append(contentsOf: segments)
        }
        
        if let checklists = self.reviewLessonViewModel.checkLists {
            array.append(contentsOf: checklists)
        }

        if (((self.reviewLessonViewModel.selected as? ModelProtocol) == nil)) {
            return 0
        }
        
        let selected = (self.reviewLessonViewModel.selected as? ModelProtocol)!
        
        for (index, object) in array.enumerated() {
            let model = (object as? ModelProtocol)!
            if model.id == selected.id && model.name == selected.name {
                return index
            }
        }
        
        return 0
    }
    
    /// Get Viewcontroller
    ///
    /// - Returns: UIViewController
    func getViewController(by index: Int) -> UIViewController {
        var controller = UIViewController()
        
        if viewControllerIndexLoaded.contains(currentPage) {
            if let controller = viewControllerLoaded[currentPage] {
                self.currentViewController = controller
                return self.currentViewController
            }
        }
        
        if let count = self.reviewLessonViewModel.segments?.count {
            if index < count {
                let segment = self.reviewLessonViewModel.segments?[index]
                let viewController = (self.getViewController(withIdentifier: "MarkdownViewController") as? MarkdownViewController)!
                viewController.markdownViewModel.segment = segment
                controller = viewController
                
                viewControllerIndexLoaded.append(currentPage)
                viewControllerLoaded[currentPage] = controller
                self.currentViewController = controller
                addViewLessonOnScrollView()
            } else {
                if self.reviewLessonViewModel.checkLists?.count ?? 0 > 0 {
                    let checklist = self.reviewLessonViewModel.checkLists?[index - count]
                    let viewController = (self.getViewController(withIdentifier: "LessonCheckListViewController") as? LessonCheckListViewController)!
                    viewController.lessonCheckListViewModel.category = self.reviewLessonViewModel.category
                    viewController.lessonCheckListViewModel.checklist = checklist
                    controller = viewController
                    
                    viewControllerIndexLoaded.append(currentPage)
                    viewControllerLoaded[currentPage] = controller
                    self.currentViewController = controller
                    addViewLessonOnScrollView()
                }
            }
        }
        
        return controller
    }
    
    /// Get Viewcontrollers
    ///
    /// - Returns: [UIViewController]
    func getObject(by index: Int) -> Any? {
        
        if let count = self.reviewLessonViewModel.segments?.count {
            if index < count {
                return self.reviewLessonViewModel.segments?[index]
            } else {
                return self.reviewLessonViewModel.checkLists?[index - count]
            }
        }
        
        return nil
    }
    
    /// Get ViewController with Identifier
    ///
    /// - Parameter identifier: String
    /// - Returns: UIViewController
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Lesson", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    fileprivate func addViewLessonOnScrollView() {
        var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        frame.origin.x = self.reviewScrollView.frame.size.width * CGFloat(currentPage)
        frame.size = self.reviewScrollView.frame.size
        
        if let subView = self.currentViewController.view {
            subView.frame = frame
            subView.tag = currentPage
            self.reviewScrollView.addSubview(subView)
        }
    }
    
    /// Set position of the workflow tabs
    fileprivate func loadContentCurrentPosition() {
        
        self.currentViewController = getViewController(by: self.currentPage)
        
        if self.reviewLessonViewModel.selected is Segment {
            let segment = (self.reviewLessonViewModel.selected as? Segment)
            loadSegment(index: currentPage, viewController: self.currentViewController, segment: segment)
        } else if self.reviewLessonViewModel.selected is CheckList {
            let checklist = (self.reviewLessonViewModel.selected as? CheckList)
            loadChecklist(index: currentPage, viewController: self.currentViewController, checklist: checklist)
        }
    }
    
    /// Load segment selected
    ///
    /// - Parameters:
    ///   - index: Int
    ///   - viewController: UIViewController
    ///   - segment: Segment
    /// - Returns: Bool
    fileprivate func loadSegment(index: Int, viewController: UIViewController, segment: Segment?) {
        let controller = (viewController as? MarkdownViewController)
        
        if controller?.markdownViewModel.segment?.id == segment?.id {
            self.sideScrollView.scrollViewDidPage(page: CGFloat(index))
            self.reviewScrollView.contentOffset = CGPoint(x: self.reviewScrollView.frame.size.width * CGFloat(index), y: 0)
            
            // Set title navigationController
            if let name = controller?.markdownViewModel.segment?.name {
                self.title = name
            }
            
            controller?.loadMarkdown()
        }
    }
    
    /// Load checklist selected
    ///
    /// - Parameters:
    ///   - index: Int
    ///   - viewController: UIViewController
    ///   - segment: Segment
    /// - Returns: Bool
    fileprivate func loadChecklist(index: Int, viewController: UIViewController, checklist: CheckList?) {
        let controller = (viewController as? LessonCheckListViewController)
        
        if controller?.lessonCheckListViewModel.checklist?.id == checklist?.id {
            self.sideScrollView.scrollViewDidPage(page: CGFloat(index))
            self.reviewScrollView.contentOffset = CGPoint(x: self.reviewScrollView.frame.size.width * CGFloat(index), y: 0)
            
            // Set title navigationController
            self.title = "Checklist".localized()
            
            if !viewControllerIndexLoaded.contains(currentPage) {
                viewControllerIndexLoaded.append(currentPage)
                viewControllerLoaded.insert(controller!, at: currentPage)
            }
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        var objectsToShare:[Any] = [Any]()
        
        // MarkdownViewController
        if self.currentViewController is MarkdownViewController {
            let controller = (self.currentViewController as? MarkdownViewController)!
            
            let name = controller.markdownViewModel.segment!.name!.components(separatedBy: .whitespacesAndNewlines).joined()
            let fm = FileManager.default
            guard let pdfURL = fm.documentsURL?.appendingPathComponent("\(name).pdf") else { return }
            
            let renderer = HTML2PDFRenderer()
            renderer.render(webView: controller.markdownWebView, toPDF: pdfURL, paperSize: .a4)
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
            // LessonCheckListViewController
        else if self.currentViewController is LessonCheckListViewController {
            let controller = (self.currentViewController as? LessonCheckListViewController)!
            
            var content: String = ""
            
            content += """
            <html>
            <head>
            <meta charset="UTF-8"> \n
            """
            content += "<title>\(controller.lessonCheckListViewModel.category!.name ?? "") - Checklist</title> \n"
            content += "</head> \n"
            content += "<body style=\"display:block;width:100%;\"> \n"
            content += "<h1>Checklist</h1> \n"
            
            for checkItem in (controller.lessonCheckListViewModel.checklist?.items)! {
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
    
    func updateTitleBar(page: CGFloat) {
        self.sideScrollView.scrollViewDidPage(page: page)
        self.view.endEditing(true)
    }
}

//
// MARK: - UIScrollViewDelegate
extension ReviewLessonViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateDidScroll(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        updateTitleBar(page: page)
    }
    
    func updateDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        if page >= 0 {
            self.currentPage = Int(page)
            self.reviewLessonViewModel.selected = getObject(by: currentPage)
            loadContentCurrentPosition()
        }
    }
}

//
// MARK: - StepperViewDataSource
extension ReviewLessonViewController: SideScrollLessonViewDataSource {
    
    func viewAtIndex(_ index: Int) -> UIView {
        
        //ViewMain
        let titleFormView = TitleLessonView(frame: CGRect(x: CGFloat(index) * self.sideScrollView.visivelPercentualSize, y: 2, width: self.sideScrollView.viewWidth(index: index), height: self.sideScrollView.frame.size.height-5))
        
        //Title
        titleFormView.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: titleFormView.frame.size.width, height: titleFormView.frame.size.height))
        titleFormView.titleLabel?.font = UIFont(name: "SFProText-SemiBold", size: 11)
        titleFormView.titleLabel?.textAlignment = .center
        titleFormView.titleLabel?.numberOfLines = 0
        titleFormView.titleLabel?.minimumScaleFactor = 0.5
        titleFormView.titleLabel?.adjustsFontSizeToFitWidth = true
        titleFormView.addSubview(titleFormView.titleLabel!)
        
        let object = self.getObject(by: index)
        
        if object is CheckList {
            titleFormView.setTitle("Checklist".localized())
        } else {
            let segment = (object as? Segment)!
            titleFormView.setTitle(segment.name ?? "")
        }
        
        return titleFormView
    }
    
    func numberOfTitles() -> Int {
        return pages
    }
}
