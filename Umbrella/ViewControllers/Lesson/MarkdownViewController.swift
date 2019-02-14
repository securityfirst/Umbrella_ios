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
import SafariServices

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
                
                let html = HTML(nameFile: "index.html", content: segment.content!)
                html.prepareHtmlWithStyle()
                let export = Export(html)
                let url = export.makeExport()
                
                //Load html
                self.markdownWebView.loadFileURL(url, allowingReadAccessTo: documentsPathURL)
            }
        }
    }
}

extension MarkdownViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.markdownWebView.isHidden = false
    }
    
    //    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    //        print("\(navigationResponse.response)")
    //    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        
        switch navigationAction.navigationType {
        case .linkActivated:
            if navigationAction.request.url?.scheme == "umbrella" {
                UIApplication.shared.open(navigationAction.request.url!)
            } else {
                let safariViewController = SFSafariViewController(url: navigationAction.request.url!)
                safariViewController.delegate = self
                UIApplication.shared.delegate!.window?!.rootViewController!.present(safariViewController, animated: true)
                decisionHandler(.cancel)
                return
            }
        default:
            break
        }
        
        decisionHandler(.allow)
    }
}

extension MarkdownViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
