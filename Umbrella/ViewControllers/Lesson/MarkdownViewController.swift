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
    
    @IBOutlet weak var markdownView: MarkdownView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let modeBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.shareAction(_:)))
        self.navigationItem.rightBarButtonItem  = modeBarButton
        
        if let segment = self.markdownViewModel.segment {
            self.markdownView.load(markdown: segment.content)
            self.title = segment.name
        }
        
    }
    
    //
    // MARK: - Actions
    
    @IBAction func shareAction(_ sender: UIBarButtonItem) {
        
    }

}
