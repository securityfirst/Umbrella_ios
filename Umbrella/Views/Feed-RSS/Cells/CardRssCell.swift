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
    func configure(withViewModel viewModel:ListRssViewModel, indexPath: IndexPath) {
        
        let item = viewModel.items[indexPath.row]
        self.titleLabel.text = item.title
        
        Global.dateFormatter.dateFormat = "MM/dd/YYYY HH:mm"
        self.authorLabel.text = ""
        if let date = item.pubDate {
            self.authorLabel.text = Global.dateFormatter.string(from: date)
        }
        
        if let mediaThumbnail = item.media?.mediaThumbnails?.first, let urlMediaThumbnail = mediaThumbnail.attributes?.url {
            self.thumbImageView.setImage(withUrl: urlMediaThumbnail)
        }
        
        if let mediaContent = item.media?.mediaContents?.first, let urlMediaContent = mediaContent.attributes?.url {
            self.thumbImageView.setImage(withUrl: urlMediaContent)
        }
    }

}
