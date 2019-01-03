//
//  MarkdownViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 21/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import MarkdownView
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
    
    @IBOutlet weak var markdownWebView: WKWebView!

    
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
            
//            let repository = UserDefaults.standard.object(forKey: "repository")
//            segment.content = segment.content?.replacingOccurrences(of: "#DOCUMENTS", with: "\(repository!)/raw/master")

//            self.markdownView.load(markdown: segment.content, enableImage: true)
//            self.markdownView.onRendered = { [weak self] height in
//                self?.markdownView.isHidden = false
//                self?.view.setNeedsLayout()
//            }
            
            
            if let documentsPathURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                var path = documentsPathURL.absoluteString
                path.removeLast()

                path = path.replacingOccurrences(of: "file://", with: "")

                segment.content = segment.content?.replacingOccurrences(of: "#DOCUMENTS", with: path)
                
                let html = try! Down(markdownString: segment.content!).toHTML()
                var docc = documentsPathURL
                docc.appendPathComponent("index.html")
                try! html.write(to: docc, atomically: true, encoding: .utf8)
                
                self.markdownWebView.loadFileURL(docc, allowingReadAccessTo: documentsPathURL)
                
            }
        }
    }
}

extension MarkdownViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // Callback from javascript: window.webkit.messageHandlers.MyObserver.postMessage(message)
        let text = message.body as! String;
        let alertController = UIAlertController(title: "Javascript said:", message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("OK")
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension MarkdownViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish navigation:");
        self.markdownWebView.isHidden = false
    }
}
