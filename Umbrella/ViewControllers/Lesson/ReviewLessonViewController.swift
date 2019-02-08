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
    var currentPage: CGFloat = 0
    var button: UIButton!
    
    lazy var reviewLessonViewModel: ReviewLessonViewModel = {
        let reviewLessonViewModel = ReviewLessonViewModel()
        return reviewLessonViewModel
    }()
    
    lazy var pages: [UIViewController] = {
        return getViewControllers()
    }()
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shareBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.shareAction(_:)))
        
        if reviewLessonViewModel.isGlossary {
            let favouriteBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "iconFavourite").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(self.favouriteAction(_:)))
            self.navigationItem.rightBarButtonItems = [shareBarButton, favouriteBarButton]
        } else {
            self.navigationItem.rightBarButtonItem = shareBarButton
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for (index, viewController) in pages.enumerated() {
            var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            frame.origin.x = self.reviewScrollView.frame.size.width * CGFloat(index)
            frame.size = self.reviewScrollView.frame.size
            
            if let subView = viewController.view {
                subView.frame = frame
                subView.tag = index
                
                self.reviewScrollView.addSubview(subView)
            }
        }
        
        self.reviewScrollView.contentSize = CGSize(width: self.reviewScrollView.frame.size.width * CGFloat(pages.count), height: self.reviewScrollView.frame.size.height)
        setCurrentPosition()
        
        self.sideScrollView.dataSource = self
        self.sideScrollView.reloadData()
    }
    
    //
    // MARK: - Functions
    
    /// Get Viewcontrollers
    ///
    /// - Returns: [UIViewController]
    func getViewControllers() -> [UIViewController] {
        var viewControllers = [UIViewController]()
        
        self.reviewLessonViewModel.segments?.forEach({ (segment) in
            let viewcontroller = (self.getViewController(withIdentifier: "MarkdownViewController") as? MarkdownViewController)!
            viewcontroller.markdownViewModel.segment = segment
            viewControllers.append(viewcontroller)
        })
        
        self.reviewLessonViewModel.checkLists?.forEach({ (checklist) in
            let viewcontroller = (self.getViewController(withIdentifier: "LessonCheckListViewController") as? LessonCheckListViewController)!
            viewcontroller.lessonCheckListViewModel.category = self.reviewLessonViewModel.category
            viewcontroller.lessonCheckListViewModel.checklist = checklist
            viewControllers.append(viewcontroller)
        })
        
        return viewControllers
    }
    
    /// Get ViewController with Identifier
    ///
    /// - Parameter identifier: String
    /// - Returns: UIViewController
    func getViewController(withIdentifier identifier: String) -> UIViewController {
        return UIStoryboard(name: "Lesson", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    /// Set position of the workflow tabs
    fileprivate func setCurrentPosition() {
        var segment:Segment? = nil
        var checklist:CheckList? = nil
        
        if self.reviewLessonViewModel.selected is Segment {
            segment = (self.reviewLessonViewModel.selected as? Segment)
        } else if self.reviewLessonViewModel.selected is CheckList {
            checklist = (self.reviewLessonViewModel.selected as? CheckList)
        }
        
        for (index, viewController) in pages.enumerated() {
            if viewController is MarkdownViewController, loadSegment(index: index, viewController: viewController, segment: segment) {
                break
            }
            
            if viewController is LessonCheckListViewController, loadChecklist(index: index, viewController: viewController, checklist: checklist) {
                break
            }
        }
    }
    
    /// Load segment selected
    ///
    /// - Parameters:
    ///   - index: Int
    ///   - viewController: UIViewController
    ///   - segment: Segment
    /// - Returns: Bool
    fileprivate func loadSegment(index: Int, viewController: UIViewController, segment: Segment?) -> Bool {
        let controller = (viewController as? MarkdownViewController)!
        
        if controller.markdownViewModel.segment?.id == segment?.id {
            self.sideScrollView.scrollViewDidPage(page: CGFloat(index))
            self.reviewScrollView.contentOffset = CGPoint(x: self.reviewScrollView.frame.size.width * CGFloat(index), y: 0)
            
            // Set title navigationController
            if let name = controller.markdownViewModel.segment?.name {
                self.title = name
            }
            
            controller.loadMarkdown()
            return true
        }
        
        return false
    }
    
    /// Load checklist selected
    ///
    /// - Parameters:
    ///   - index: Int
    ///   - viewController: UIViewController
    ///   - segment: Segment
    /// - Returns: Bool
    fileprivate func loadChecklist(index: Int, viewController: UIViewController, checklist: CheckList?) -> Bool {
        let controller = (viewController as? LessonCheckListViewController)!
        
        if controller.lessonCheckListViewModel.checklist?.id == checklist?.id {
            self.sideScrollView.scrollViewDidPage(page: CGFloat(index))
            self.reviewScrollView.contentOffset = CGPoint(x: self.reviewScrollView.frame.size.width * CGFloat(index), y: 0)
            
            // Set title navigationController
            self.title = "CheckList".localized()
            return true
        }
        return false
    }
    
    //
    // MARK: - Actions
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        var objectsToShare:[Any] = [Any]()
        let viewController = self.pages[Int(currentPage)]
        
        // MarkdownViewController
        if viewController is MarkdownViewController {
            let controller = (viewController as? MarkdownViewController)!
            
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
        else if viewController is LessonCheckListViewController {
            let controller = (viewController as? LessonCheckListViewController)!
            
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
    
    @IBAction func favouriteAction(_ sender: UIBarButtonItem) {
        let viewController = self.pages[Int(currentPage)]
        
        // MarkdownViewController
        if viewController is MarkdownViewController {
            let controller = (viewController as? MarkdownViewController)!
            
            controller.markdownViewModel.segment!.favourite = !controller.markdownViewModel.segment!.favourite
            
            if controller.markdownViewModel.segment!.favourite {
                
                let favouriteSegment = FavouriteLesson(categoryId: self.reviewLessonViewModel.category!.id, difficultyId: 0, segmentId: controller.markdownViewModel.segment!.id)
                
                self.reviewLessonViewModel.insert(favouriteSegment)
            } else {
                self.reviewLessonViewModel.remove(controller.markdownViewModel.segment!.id)
            }
        }
            // LessonCheckListViewController
        else if viewController is LessonCheckListViewController {
            let controller = (viewController as? LessonCheckListViewController)!
            
            controller.lessonCheckListViewModel.checklist!.favourite = !controller.lessonCheckListViewModel.checklist!.favourite
            
            if controller.lessonCheckListViewModel.checklist!.favourite {
                let favouriteSegment = FavouriteLesson(categoryId: self.reviewLessonViewModel.category!.parent, difficultyId: self.reviewLessonViewModel.category!.id, segmentId: -1)
                self.reviewLessonViewModel.insert(favouriteSegment)
            } else {
                self.reviewLessonViewModel.removeFavouriteChecklist(self.reviewLessonViewModel.category!.parent, difficultyId: self.reviewLessonViewModel.category!.id)
            }
        }
    }
}

//
// MARK: - UIScrollViewDelegate
extension ReviewLessonViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateDidScroll(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateDidScroll(scrollView)
    }
    
    func updateDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        currentPage = pageNumber
        self.sideScrollView.scrollViewDidPage(page: currentPage)
        self.view.endEditing(true)
        
        let viewController = self.pages[Int(currentPage)]
        
        if viewController is MarkdownViewController {
            let controller = (viewController as? MarkdownViewController)!
            if let name = controller.markdownViewModel.segment?.name {
                self.title = name
            }
            self.reviewLessonViewModel.selected = controller.markdownViewModel.segment
            controller.loadMarkdown()
        } else if viewController is LessonCheckListViewController {
            let controller = (viewController as? LessonCheckListViewController)!
            self.title = "CheckList".localized()
            self.reviewLessonViewModel.selected = controller.lessonCheckListViewModel.checklist
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
        
        let viewController = self.pages[index]
        
        if viewController is LessonCheckListViewController {
            titleFormView.setTitle("CheckList".localized())
        } else {
            let controller = (viewController as? MarkdownViewController)!
            titleFormView.setTitle(controller.markdownViewModel.segment?.name ?? "")
        }
        
        return titleFormView
    }
    
    func numberOfTitles() -> Int {
        return pages.count
    }
}
