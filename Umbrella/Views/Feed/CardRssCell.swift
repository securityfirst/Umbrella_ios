//
//  CardRssCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 29/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class CardRssCell: UITableViewCell {

    //
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
