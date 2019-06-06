//
//  PathwaySeeAllCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class PathwaySeeAllCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Configure the cell
    func configure() {
        self.titleLabel.text = "See all".localized()
    }
    
}
