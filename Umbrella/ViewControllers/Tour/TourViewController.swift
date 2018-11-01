//
//  TourViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 20/08/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import WebKit

class TourViewController: UIViewController {

    //
    // MARK: - Properties
    @IBOutlet weak var tourScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    var currentPage: Int = 0
    
    static let robotoBold = "Roboto-Bold"
    
    //
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addTourPageView(position: 0, icon: #imageLiteral(resourceName: "tour1"), backgroundColor: #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1), text: "Umbrella makes your security simple".localized())
        addTourPageView(position: 1, icon: #imageLiteral(resourceName: "tour2"), backgroundColor: #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1), text: "Get advice on everything from sending a secure email to safe travel".localized())
        addTourPageView(position: 2, icon: #imageLiteral(resourceName: "tour3"), backgroundColor: #colorLiteral(red: 0.9661672711, green: 0.7777593136, blue: 0.215906769, alpha: 1), text: "Use checklists to mark your progress".localized())
        addTourPageView(position: 3, icon: #imageLiteral(resourceName: "tour4"), backgroundColor: #colorLiteral(red: 0.7787129283, green: 0.3004907668, blue: 0.4151412845, alpha: 1), text: "Stay up to date with the latest information on where you are".localized())
        
        addWebView()
        
        self.tourScrollView.contentSize = CGSize(width: 5*self.tourScrollView.frame.size.width, height: self.tourScrollView.frame.size.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    // MARK: - Functions
    
    /// Add term webview
    fileprivate func addWebView() {
        let view = UIView(frame: CGRect(x: 4*self.tourScrollView.frame.size.width, y: 0, width:self.tourScrollView.frame.size.width, height: self.tourScrollView.frame.size.height))
        view.backgroundColor = #colorLiteral(red: 0.9661672711, green: 0.7777593136, blue: 0.215906769, alpha: 1)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 30, width: self.tourScrollView.frame.size.width, height: 40))
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleLabel.tag = 999
        titleLabel.font = UIFont(name: TourViewController.robotoBold, size: 20)
        titleLabel.textAlignment = .center
        titleLabel.text = "Terms and Conditions".localized()
        view.addSubview(titleLabel)
        
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        let webView = WKWebView(frame: CGRect(x: 20, y: 80, width: self.tourScrollView.frame.size.width-40, height: self.tourScrollView.frame.size.height-160), configuration: wkWebConfig)
        webView.navigationDelegate = self
        webView.layer.cornerRadius = 12
        webView.layer.masksToBounds = true
        
        let url = Bundle.main.url(forResource: "terms", withExtension: "html")
        view.addSubview(webView)
        
        let request = URLRequest(url: url!)
        webView.load(request)
        
        let acceptButton = UIButton(frame: CGRect(x: self.tourScrollView.frame.size.width-100, y: webView.frame.origin.y + webView.frame.size.height + 10, width: 80, height: 40))
        acceptButton.setTitle("ACCEPT".localized(), for: .normal)
        acceptButton.titleLabel?.font = UIFont(name: TourViewController.robotoBold, size: 20)
        acceptButton.addTarget(self, action: #selector(acceptAction), for: .touchUpInside)
        view.addSubview(acceptButton)
        self.tourScrollView.addSubview(view)
    }
    
    /// Accept action
    @objc func acceptAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = (storyboard.instantiateViewController(withIdentifier: "LoadingViewController") as? LoadingViewController)!
        UIApplication.shared.keyWindow?.addSubview(controller.view)
        controller.loadTent {
            UserDefaults.standard.set(true, forKey: "acceptTerm")
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    /// Add tour page in view
    ///
    /// - Parameters:
    ///   - position: position of the view
    ///   - icon: icon
    ///   - backgroundColor: color
    ///   - text: description
    func addTourPageView(position: Int, icon: UIImage, backgroundColor: UIColor, text: String) {
        let tourView = UIView(frame: CGRect(x: CGFloat(position)*self.tourScrollView.frame.size.width, y: 0, width:self.tourScrollView.frame.size.width, height: self.tourScrollView.frame.size.height))
        tourView.backgroundColor = backgroundColor
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 70, width: self.tourScrollView.frame.size.width, height: self.tourScrollView.frame.size.height/2))
        imageView.image = icon
        imageView.contentMode = .scaleAspectFit
        tourView.addSubview(imageView)
        
        let textLabel = UILabel(frame: CGRect(x: 0, y: self.tourScrollView.frame.size.height/2, width: self.tourScrollView.frame.size.width, height: self.tourScrollView.frame.size.height/2))
        textLabel.tag = position
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        textLabel.font = UIFont(name: TourViewController.robotoBold, size: 24)
        textLabel.text = text
        textLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tourView.addSubview(textLabel)
        self.tourScrollView.addSubview(tourView)
    }
    
    //
    // MARK: - Actions
    
    @IBAction func pageControlAction(_ sender: Any) {
        let xPage = CGFloat(self.pageControl.currentPage) * self.tourScrollView.frame.size.width
        self.tourScrollView.setContentOffset(CGPoint(x: xPage, y: 0), animated: true)
    }
    
}

//
// MARK: - UIScrollViewDelegate
extension TourViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateDidScroll(scrollView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateDidScroll(scrollView)
    }
    
    func updateDidScroll(_ scrollView: UIScrollView) {
        let currentPage = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pageControl.currentPage = Int(currentPage)
        
        if self.currentPage != self.pageControl.currentPage {
            self.currentPage = self.pageControl.currentPage
            
            if self.pageControl.currentPage == 4 {
                for view in self.tourScrollView.subviews {
                    let result = view.subviews.filter { $0.tag == 999 }
                    
                    if let first = result.first {
                        UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: first)
                    }
                }
                return
            }
            
            for view in self.tourScrollView.subviews {
                let result = view.subviews.filter { $0.tag == self.pageControl.currentPage }
                
                if let first = result.first {
                    UIAccessibility.post(notification: UIAccessibility.Notification.layoutChanged, argument: first)
                }
            }
        }
    }
}

//
// MARK: - WKNavigationDelegate
extension TourViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == WKNavigationType.linkActivated {
            guard let url = URL(string: (navigationAction.request.url?.absoluteString)!) else { return }
                UIApplication.shared.open(url)
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
}
