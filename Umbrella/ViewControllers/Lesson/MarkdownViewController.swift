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
                
                let results = searchForFileString(content: segment.content!)
                
                if let results = results {
                    for file in results {
                        if !checkIfExistFile(file: file) {
                            changeFileToDefaultLanguange(content: &segment.content!, file: file)
                        }
                    }
                }
                
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
    
    /// Search for file string in content
    ///
    /// - Parameter content: String
    /// - Returns: [String]
    fileprivate func searchForFileString(content: String) -> [String]? {
        do {
            let regex = try NSRegularExpression(pattern:"\\(#DOCUMENTS([^)]+)\\)", options: [])
            var results = [String]()
            regex.enumerateMatches(in: content, options: [], range: NSRange(location: 0, length: content.utf16.count)) { result, flags, stop in
                if let result = result?.range(at: 1), let range = Range(result, in: content) {
                    results.append(String(content[range]))
                }
            }
            return results
        } catch {
            print(error)
            return nil
        }
    }
    
    /// Change file string to the default language EN
    ///
    /// - Parameters:
    ///   - content: String
    ///   - file: String
    fileprivate func changeFileToDefaultLanguange(content: inout String, file: String?) {
        if let file = file {
            print(file.components(separatedBy: "/"))
            let language = file.components(separatedBy: "/")[1]
            content = content.replacingOccurrences(of: file, with: file.replacingOccurrences(of: "/\(language)/", with: "/en/"))
        }
    }
    
    /// Check if exist file in documents
    ///
    /// - Parameter file: String
    /// - Returns: Bool
    fileprivate func checkIfExistFile(file: String) -> Bool {
        
        if file.contains("/en/") {
            return true
        }
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        guard documentsUrl.count != 0 else {
            return false
        }
        
        let finalDatabaseURL = documentsUrl.first!.appendingPathComponent(file)
        
        if ( (try? finalDatabaseURL.checkResourceIsReachable()) ?? false) {
            return true
        }
        
        return false
    }
}

extension MarkdownViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.markdownWebView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        
        switch navigationAction.navigationType {
        case .linkActivated:
            if navigationAction.request.url?.scheme == "umbrella" {
                UIApplication.shared.open(navigationAction.request.url!)
            } else {
                if (navigationAction.request.url?.scheme?.contains("http"))! {
                    let safariViewController = SFSafariViewController(url: navigationAction.request.url!)
                    safariViewController.delegate = self
                    UIApplication.shared.delegate!.window?!.rootViewController!.present(safariViewController, animated: true)
                }
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
