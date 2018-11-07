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
        
        let item = viewModel.feedItems[indexPath.row]
        
        if let titleLabel = self.titleLabel {
            titleLabel.text = item.title
        }
        
        if let url = URL(string: item.url) {
            if let dateLabel = self.dateLabel {
                dateLabel.text = "Via \(url.host ?? "") \(item.dateString)"
            }
        }
        
        do {
            DispatchQueue.global(qos: .default).async {
            let theAttributedString = try? NSAttributedString(data: item.description.data(using: String.Encoding.utf8, allowLossyConversion: false)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
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
