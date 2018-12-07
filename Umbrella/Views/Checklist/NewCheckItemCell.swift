//
//  NewCheckItemCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 05/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

protocol NewCheckItemDelegate: class {
    func checkAction(indexPath: IndexPath)
    func editTextAction(indexPath: IndexPath, cell: NewCheckItemCell)
}

class NewCheckItemCell: UITableViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editText: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: NewCheckItemDelegate?
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
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:NewChecklistViewModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.titleLabel.text = ""
        self.editText.text = ""
        
        let item = viewModel.customChecklist.items[indexPath.row]
        self.titleLabel.text = item.name
        
        let checklistChecked = viewModel.customChecklistChecked.filter {$0.customChecklistId == viewModel.customChecklist.id && $0.itemId == item.id }.first
        
        if checklistChecked != nil {
            item.checked = true
        }
        
        self.checkImageView.image = item.checked ? #imageLiteral(resourceName: "checkSelected") : #imageLiteral(resourceName: "groupNormal")
    }
    
    /// Mode edit
    ///
    /// - Parameter enable: Bool
    func modeEdit(enable: Bool) {
        self.titleLabel.isHidden = enable
        self.editText.isHidden = !enable
    }
    
    //
    // MARK: - Actions
    
    @IBAction func checkAction(_ sender: Any) {
        self.delegate?.checkAction(indexPath: self.indexPath)
    }
    
    @IBAction func editTextAction(_ sender: Any) {
        self.delegate?.editTextAction(indexPath: self.indexPath, cell: self)
    }
}
