//
//  FormCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 09/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FormCell: UITableViewCell {

    //
    // MARK: - Properties
    @IBOutlet weak var formBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //
    // MARK: - Life cycle
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
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:FormViewModel, indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let form = viewModel.umbrella.forms[indexPath.row]
            titleLabel.text = form.name
        } else if indexPath.section == 1 {
            let form = viewModel.umbrella.formAnswers[indexPath.row]
            titleLabel.text = form.createdAt
        }
    }

}
