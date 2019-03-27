//
//  SingleChoiceCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class SingleChoiceCell: BaseFormCell {
    
    //
    // MARK: - Properties
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    weak var delegate: BaseFormCellDelegate?
    
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
    
    /// Configure the cell with data by ViewModel
    ///
    /// - Parameters:
    ///   - viewModel: viewModel
    ///   - indexPath: indexPath
    func configure(withViewModel viewModel:DynamicFormViewModel, indexPath: IndexPath) {
        let itemForm = viewModel.screen.items[indexPath.row]
        
        var yLabel:CGFloat = 0.0
        if itemForm.label.count > 0 {
            let label = UILabel(frame: CGRect(x: 10, y: 5, width: self.frame.size.width - 10, height: 33))
            label.text = itemForm.label
            label.font = UIFont(name: "Roboto-Regular", size: 12)
            label.numberOfLines = 2
            label.adjustsFontSizeToFitWidth = true
            self.addSubview(label)
            yLabel = 40.0
        }
        
        for (index, optionItem) in itemForm.options.enumerated() {
            let xItem: CGFloat = 5.0
            let height: CGFloat = 33.0
            
            let button = ChoiceButton(frame: CGRect(x: xItem, y: (CGFloat(index)*height)+yLabel, width: self.frame.size.width - xItem - 5.0, height: height))
            button.setTitle(optionItem.label)
            button.index = optionItem.id
            button.choiceType = .single
            button.setState(state: false)
            self.addSubview(button)
            
            button.changeState { index in
                for view in self.subviews where view is ChoiceButton {
                    let button = (view as? ChoiceButton)!
                    if button.index != index {
                        button.setState(state: false)
                    }
                }
            }
            
            //Load answers
            for formAnswer in viewModel.formAnswers where (formAnswer.itemFormId == itemForm.id && formAnswer.optionItemId == optionItem.id) {
                button.setState(state: true)
            }
        }
    }
    
    /// Save the data in database
    override func saveForm() {
        for view in self.subviews where view is ChoiceButton {
            let button = (view as? ChoiceButton)!
            if button.state {
                self.delegate?.saveForm(cell: self, indexPath: self.indexPath)
                break
            }
        }
    }
}
