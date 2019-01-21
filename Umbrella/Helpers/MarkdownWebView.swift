//
//  MarkdownWebView.swift
//  Umbrella
//
//  Created by Lucas Correa on 07/01/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit
import WebKit

class MarkdownWebView: WKWebView {

    required convenience init?(coder: NSCoder) {
        let jscript = ""
        let userScript = WKUserScript(source: jscript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        self.init(frame: .zero, configuration: wkWebConfig)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.isScrollEnabled = true
        self.allowsBackForwardNavigationGestures = false
        self.contentMode = .scaleToFill
    }
}
