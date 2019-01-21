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
                    var html = try Down(markdownString: segment.content!).toHTML()
                    
                    html = """
                    <html>
                        <head>
                            <style>
                                body{
                                    color:#444444;
                                    font-size:300%;
                                }
                                img{
                                    width:100%
                                }
                                h1{
                                    color:#33b5e5;
                                    font-weight:normal;
                                }
                                h2{
                                    color:#9ABE2E;
                                    font-weight:normal;
                                }
                                getDifficultyFromId{
                                    color:#33b5e5
                                }
                                .button,.button:link{
                                    display:block;
                                    text-decoration:none;
                                    color:white;
                                    border:none;
                                    width:100%;
                                    text-align:center;
                                    border-radius:3px;
                                    padding-top:10px;
                                    padding-bottom:10px;
                                }
                                .green{
                                    background:#9ABE2E
                                }
                                .purple{
                                    background:#b83656
                                }
                                .yellow{
                                    background:#f3bc2b
                                }
                            </style>
                        </head>
                        <body>
                            \(html)
                        </body>
                    </html>
                    """
                    var docc = documentsPathURL
                    print("\n\(html)\n")
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
