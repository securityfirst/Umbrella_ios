//
//  SegmentViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class SegmentViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var segmentViewModel: SegmentViewModel = {
        let segmentViewModel = SegmentViewModel()
        return segmentViewModel
    }()
    
    @IBOutlet weak var emptyLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var segmentCollectionView: UICollectionView!
    var menuView: BTNavigationDropdownMenu?
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.segmentViewModel.category?.name
        
        if self.segmentViewModel.difficulties.count > 1 {
            
            var items: [String] = [String]()
            for category in segmentViewModel.difficulties {
                items.append(category.name ?? "")
            }
            
            self.menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title(self.segmentViewModel.category?.name ?? ""), items: items)
            
            self.menuView?.arrowTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            self.menuView?.checkMarkImage = #imageLiteral(resourceName: "iconCheckmark")
            self.navigationItem.titleView = self.menuView
            
            self.menuView?.didSelectItemAtIndexHandler = { indexPath in
                self.segmentViewModel.category = self.segmentViewModel.difficulties[indexPath]
                self.segmentCollectionView.reloadData()
                
                if let category = self.segmentViewModel.category {
                    self.title = category.name
                    let difficultyRule = DifficultyRule(categoryId: category.parent, difficultyId: category.id)
                    self.segmentViewModel.insert(difficultyRule)
                }
            }
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.menuView?.hide()
    }
    
    //
    // MARK: - UIStoryboardSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "markdownSegue" {
            let markdownViewController = (segue.destination as? MarkdownViewController)!
            
            let segment = (sender as? Segment)!
            markdownViewController.markdownViewModel.segment = segment
        } else if segue.identifier == "checkListSegue" {
            let lessonCheckListViewController = (segue.destination as? LessonCheckListViewController)!
            
            let dictionary = (sender as? [String: Any])!
            lessonCheckListViewController.lessonCheckListViewModel.checklist = (dictionary["checkList"] as? CheckList)!
            lessonCheckListViewController.lessonCheckListViewModel.category = (dictionary["category"] as? Category)!
        }
    }
    
    //
    // MARK: - Functions
    
    func checkIfEmptyList() {
        self.segmentCollectionView.isHidden = self.segmentViewModel.category?.segments.count == 0
        self.searchBar.isHidden = self.segmentCollectionView.isHidden
    }
}

//
// MARK: - UICollectionViewDelegate
extension SegmentViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let segment = self.segmentViewModel.getSegments()[indexPath.row]
            self.performSegue(withIdentifier: "markdownSegue", sender: segment)
        } else if indexPath.section == 1 {
            let checklist = self.segmentViewModel.category?.checkList[indexPath.row]
            self.performSegue(withIdentifier: "checkListSegue", sender: ["checkList": checklist!, "category": self.segmentViewModel.category!])
        }
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
        } else if section == 1 {
            
            if let category = self.segmentViewModel.category {
                return category.checkList.count
            }
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
                
                let favouriteSegment = FavouriteSegment(categoryId: self.segmentViewModel.category!.parent, difficultyId: self.segmentViewModel.category!.id, segmentId: segment.id)
                
                self.segmentViewModel.insert(favouriteSegment)
            } else {
                self.segmentViewModel.remove(segment.id)
                
                if self.segmentViewModel.category?.name == "Favourites".localized() {
                    var segments = self.segmentViewModel.getSegments()
                    segments.remove(at: indexPath.row)
                }
            }
            
            if self.segmentViewModel.category?.name == "Favourites".localized() {
                self.checkIfEmptyList()
                self.segmentCollectionView.reloadData()
            } else {
                self.segmentCollectionView.reloadItems(at: [indexPath])
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
