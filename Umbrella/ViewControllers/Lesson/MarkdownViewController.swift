//
//  MarkdownViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import WebKit
import Down

class MarkdownViewController: UIViewController {
    
    //
    // MARK: - Properties
    
    lazy var markdownViewModel: MarkdownViewModel = {
        let markdownViewModel = MarkdownViewModel()
        return markdownViewModel
    }()
    var isLoading: Bool = false
    
    @IBOutlet weak var markdownWebView: MarkdownWebView!
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.markdownWebView.isHidden = true
        self.markdownWebView.navigationDelegate = self
    }
    
    //
    // MARK: - Functions
    
    /// Load Markdown
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
                
                do {
                    let html = try Down(markdownString: segment.content!).toHTML()
                    var docc = documentsPathURL
                    docc.appendPathComponent("index.html")
                    try html.write(to: docc, atomically: true, encoding: .utf8)
                    
                    self.markdownWebView.loadFileURL(docc, allowingReadAccessTo: documentsPathURL)
                } catch {
                    print("MarkdownViewController: \(error)")
                }
            }
        }
    }
}

extension MarkdownViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish navigation:")
        self.markdownWebView.isHidden = false
    }
}
