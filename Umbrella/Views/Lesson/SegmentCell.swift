//
//  SegmentCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class SegmentCell: UICollectionViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        headerView.roundCorners([.topLeft, .topRight], radius: 14)
    }
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:SegmentViewModel, indexPath: IndexPath) {
        
        headerView.backgroundColor = Lessons.colors[indexPath.row % Lessons.colors.count]
        
        if let category = viewModel.category {
            let segment = category.segments[indexPath.row]
            
            let index = ((segment.index ?? 0) == 0) ? (indexPath.row + 1) : Int(segment.index!)
            self.titleLabel.text = "\(index) \(segment.name ?? "")"
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func favouriteAction(_ sender: Any) {
        
    }
}
