//
//  FormCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FormCell: UITableViewCell {

    @IBOutlet weak var formBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //
    // MARK: - Functions
    
    func configure(withViewModel viewModel:FormViewModel, indexPath: IndexPath) {
        
        let form = viewModel.umbrella.forms[indexPath.row]
        titleLabel.text = form.name
    }

}
