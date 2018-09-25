//
//  CategoryHeaderView.swift
//  Umbrella
//
//  Created by Lucas Correa on 13/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

protocol CategoryHeaderViewDelegate: class {
    func toggleSection(header: CategoryHeaderView, section: Int)
}

class CategoryHeaderView: UITableViewHeaderFooterView {

    //
    // MARK: - Properties
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    weak var delegate: CategoryHeaderViewDelegate?
    var section: Int = 0
    var row: Int = 0
    
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
        
        self.contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    //
    // MARK: - Functions
    
    /// Action on did tap header
    @objc private func didTapHeader() {
        self.delegate?.toggleSection(header: self, section: section)
    }
    
    /// Set the collapsed of a header
    ///
    /// - Parameter collapsed: Bool
    func setCollapsed(collapsed: Bool) {
        self.arrowImageView?.rotate(collapsed ? .pi : 0.0)
    }
}
