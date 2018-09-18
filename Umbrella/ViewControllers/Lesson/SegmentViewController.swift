//
//  SegmentViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class SegmentViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var segmentViewModel: SegmentViewModel = {
        let segmentViewModel = SegmentViewModel()
        return segmentViewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
// MARK: - UICollectionViewDelegate
extension SegmentViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
            if let category = self.segmentViewModel.category {
                return category.segments.count
            } else {
                return 0
            }
            
        } else if section == 1 {
            
            if let category = self.segmentViewModel.category {
                return category.checkList.count
            } else {
                return 0
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentCell",
                                                           for: indexPath) as? SegmentCell)!
            cell.configure(withViewModel: self.segmentViewModel, indexPath: indexPath)
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
            return CGSize(width: 171, height: 187)
        } else {
            return CGSize(width: 350, height: 132)
        }
    }
}
