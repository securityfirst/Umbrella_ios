//
//  CheckListCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 17/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

protocol ChecklistCellDelegate: class {
    func favouriteChecklist(cell: CheckListCell)
}

class CheckListCell: UICollectionViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    weak var delegate: ChecklistCellDelegate?
    
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
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:SegmentViewModel, indexPath: IndexPath) {
        
        if let headerView = self.headerView {
            headerView.backgroundColor = Lessons.colors[indexPath.row % Lessons.colors.count]
        }
        
        let checklist = viewModel.category?.checkList[indexPath.row]
        
        if let iconImageView = self.iconImageView {
            if let checklist = checklist {
                iconImageView.tintColor = checklist.favourite ? #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1) : #colorLiteral(red: 0.6251067519, green: 0.6256913543, blue: 0.6430284977, alpha: 1)
            }
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func favouriteAction(_ sender: Any) {
        self.delegate?.favouriteChecklist(cell: self)
    }
    
}
