//
//  MarkdownViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import MarkdownView

class MarkdownViewController: UIViewController {
    
    //
    // MARK: - Properties
    lazy var markdownViewModel: MarkdownViewModel = {
        let markdownViewModel = MarkdownViewModel()
        return markdownViewModel
    }()
    var isLoading: Bool = false
    
    @IBOutlet weak var markdownView: MarkdownView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let modeBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.shareAction(_:)))
        self.navigationItem.rightBarButtonItem  = modeBarButton
        
        self.markdownView.isHidden = true
    }
    
    func loadMarkdown() {
        if self.isLoading {
            return
        }
        
        self.isLoading = true
        
        if let segment = self.markdownViewModel.segment {
            self.title = segment.name
            
            if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                var path = documentsPathURL.absoluteString
                path.removeLast()
                path = path.replacingOccurrences(of: "file://", with: "")
                segment.content = segment.content?.replacingOccurrences(of: "#DOCUMENTS", with: path)
                
                print(segment.content)
                print("\(path)/call1.png")
                self.imageView.image = UIImage(contentsOfFile: "\(path)/call1.png")
                
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: "\(path)/en/communications/making-a-call/beginner/call1.png") {
                    print("FILE AVAILABLE")
                } else {
                    print("FILE NOT AVAILABLE")
                }
                
                let  markdownImage = "![image](\(path)/call1.png)"
                
                self.markdownView.load(markdown: segment.content, enableImage: true)
                self.markdownView.onRendered = { [weak self] height in
                    self?.markdownView.isHidden = false
                    self?.view.setNeedsLayout()
                }
            }
        }
    }
    
    //
    // MARK: - Actions
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        
    }

}
