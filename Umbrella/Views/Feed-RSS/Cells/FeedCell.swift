//
//  FeedCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 04/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    //
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
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
    func configure(withViewModel viewModel:FeedViewModel, indexPath: IndexPath) {
        
        if viewModel.feedItems.indexExists(indexPath.row) {
            let item = viewModel.feedItems[indexPath.row]
            
            if let titleLabel = self.titleLabel {
                
                if item.title.first == " " {
                    item.title.removeFirst()
                }
                
                titleLabel.text = item.title
            }
            
            if let url = URL(string: item.url) {
                if let dateLabel = self.dateLabel {
                    dateLabel.text = "Via \(url.host ?? "") \(item.dateString)"
                }
            }
            
            item.description = item.description.replacingOccurrences(of: "\n\n", with: "\n").replacingOccurrences(of: "<p>", with: "").replacingOccurrences(of: "</p>", with: "")
            
            if let heightConstraint = self.heightConstraint {
                heightConstraint.constant = item.description.count > 0 ? 60 : 0
            }
            
            do {
                DispatchQueue.global(qos: .default).async {
                    let theAttributedString = try? NSAttributedString(data: item.description.data(using: String.Encoding.utf16, allowLossyConversion: false)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                    DispatchQueue.main.async {
                        
                        if let descriptionTextView = self.descriptionTextView {
                            descriptionTextView.attributedText = theAttributedString
                            descriptionTextView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 0, height: 0), animated: true)
                        }
                    }
                }
            }
        }
    }
}
