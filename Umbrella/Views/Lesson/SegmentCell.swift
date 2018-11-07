//
//  SegmentCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

protocol SegmentCellDelegate: class {
    func favouriteSegment(cell: SegmentCell)
}

class SegmentCell: UICollectionViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    weak var delegate: SegmentCellDelegate?
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Bugfix - In iPhone 5/5s, for some reason the direct side constraint doesn't work and the view ends up getting larger than the superview and does not show the cornerRadius correctly, so I made that modification of the frame to solve the problem.
        if let headerView = self.headerView {
            var frame = headerView.frame
            frame.size.width = self.bounds.size.width
            headerView.frame = frame
            
            headerView.roundCorners([.topRight, .topLeft], radius: 14)
        }
    }
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:SegmentViewModel, indexPath: IndexPath) {
        
        if let headerView = self.headerView {
            headerView.backgroundColor = Lessons.colors[indexPath.row % Lessons.colors.count]
        }
        
        let segment = viewModel.getSegments()[indexPath.row]
        let index = ((segment.index ?? 0) == 0) ? (indexPath.row + 1) : Int(segment.index!)
        
        if let titleLabel = self.titleLabel {
            titleLabel.text = "\(index) \(segment.name ?? "")"
        }
        
        if let iconImageView = self.iconImageView {
            iconImageView.tintColor = segment.favourite ? #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1) : #colorLiteral(red: 0.6251067519, green: 0.6256913543, blue: 0.6430284977, alpha: 1)
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func favouriteAction(_ sender: Any) {
        self.delegate?.favouriteSegment(cell: self)
    }
}
