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
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); meta.setAttribute('initial-scale', '1.0'); meta.setAttribute('maximum-scale', '1.0'); meta.setAttribute('minimum-scale', '1.0'); meta.setAttribute('user-scalable', 'no'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        self.init(frame: .zero, configuration: wkWebConfig)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.isScrollEnabled = true
        self.scrollView.bounces = false
        self.allowsBackForwardNavigationGestures = false
        self.contentMode = .scaleToFill
    }
}
