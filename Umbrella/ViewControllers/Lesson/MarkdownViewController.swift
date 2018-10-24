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
            
            //FIXME: Just for demo
//            let gitHubDemo = UserDefaults.standard.object(forKey: "gitHubDemo")
//            segment.content = segment.content?.replacingOccurrences(of: "#DOCUMENTS", with: "\(gitHubDemo!)/raw/master")
//
//            self.markdownView.load(markdown: segment.content, enableImage: true)
//            self.markdownView.onRendered = { [weak self] height in
//                self?.markdownView.isHidden = false
//                self?.view.setNeedsLayout()
//            }
            
            if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                var path = documentsPathURL.absoluteString
                path.removeLast()
                
                //I have tried with file:// it same problem
                path = path.replacingOccurrences(of: "file://", with: "")
                
                segment.content = segment.content?.replacingOccurrences(of: "#DOCUMENTS", with: path)

                print("Content: \(String(describing: segment.content)) \n\n")
                print("Path Image: \(path)/en/communications/making-a-call/beginner/call1.png \n")
                
                // The path is the same, I've added this imageView to test. In the simulator work both, but not in the device. I have tested a different 4 frameworks the same problem.
                self.imageView.image = UIImage(contentsOfFile: "\(path)/en/communications/making-a-call/beginner/call1.png")
                
                let fileManager = FileManager.default
                if fileManager.fileExists(atPath: "\(path)/en/communications/making-a-call/beginner/call1.png") {
                    print("FILE AVAILABLE")
                } else {
                    print("FILE NOT AVAILABLE")
                }

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
