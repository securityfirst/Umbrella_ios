//
//  ChecklistReviewHeaderView.swift
//  Umbrella
//
//  Created by Lucas Correa on 28/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class ChecklistReviewHeaderView: UITableViewHeaderFooterView {

    //
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    var section: Int = 0
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
