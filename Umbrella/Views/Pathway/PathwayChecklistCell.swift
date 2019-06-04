//
//  PathwayChecklistCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

protocol PathwayChecklistCellDelegate: class {
    func deletePathwayChecklist(cell: PathwayChecklistCell, indexPath: IndexPath)
}

class PathwayChecklistCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: PathwayChecklistCellDelegate!
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:PathwayViewModel, indexPath: IndexPath) {
        let checklist = viewModel.pathwayFavorite()[indexPath.row]
        self.titleLabel.text = checklist.name
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        self.delegate.deletePathwayChecklist(cell: self, indexPath: self.indexPath)
    }
}
