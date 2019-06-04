//
//  FillCheckListCell.swift
//  Umbrella
//
//  Created by Lucas Correa on 24/09/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import WebKit

protocol FillChecklistCellDelegate: class {
    func checkOrUncheck(cell: FillCheckListCell, indexPath: IndexPath)
}

class FillCheckListCell: UITableViewCell {

    //
    // MARK: - Properties
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var markdownWebView: MarkdownWebView!
    var indexPath = IndexPath(row: 0, section: 0)
    weak var delegate: FillChecklistCellDelegate?
    var touchDeeplink = false
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //
    // MARK: - Functions
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:LessonCheckListViewModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        if let checkList = viewModel.checklist {
            let item = checkList.items[indexPath.row]
            
            self.markdownWebView.isHidden = true
            self.titleLabel.isHidden = !self.markdownWebView.isHidden
            
            self.titleLabel.text = item.name
            self.checkImageView.image = item.checked ? #imageLiteral(resourceName: "checkSelected") : #imageLiteral(resourceName: "groupNormal")
            
            let language: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
            // Arabic(ar) or Persian Farsi(fa)
            if language == "ar" || language == "fa" {
                self.titleLabel.textAlignment = .right
            } else {
                self.titleLabel.textAlignment = .left
            }
        }
    }
    
    /// Configure the cell with viewModel
    ///
    /// - Parameters:
    ///   - viewModel: ViewModel
    ///   - indexPath: IndexPath
    func configure(withViewModel viewModel:PathwayViewModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        if let checkList = viewModel.checklist {
            let item = checkList.items[indexPath.row]
            
            self.titleLabel.text = item.name
            self.checkImageView.image = item.checked ? #imageLiteral(resourceName: "checkSelected") : #imageLiteral(resourceName: "groupNormal")
            
            let html = HTML(nameFile: "index.html", content: item.name)
            html.prepareHtmlWithStyleDeeplink()
            
            let language: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
            // Arabic(ar) or Persian Farsi(fa)
            if language == "ar" || language == "fa" {
                html.content = html.content.replacingOccurrences(of: "#align#"  , with: "right")
            } else {
                html.content = html.content.replacingOccurrences(of: "#align#"  , with: "left")
            }
            self.markdownWebView.navigationDelegate = self
            self.markdownWebView.loadHTMLString(html.content, baseURL: nil)
            self.markdownWebView.scrollView.isScrollEnabled = false
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tap))
            gesture.delegate = self
            for recognizer in self.markdownWebView.gestureRecognizers ?? [] {
                self.markdownWebView.removeGestureRecognizer(recognizer)
            }
            self.markdownWebView.addGestureRecognizer(gesture)
        }
    }
    
    @objc func tap() {
        print(Date())
        self.touchDeeplink = false
        delay(0.35) {
            if !self.touchDeeplink {
                print("touch on cell")
                self.delegate?.checkOrUncheck(cell: self, indexPath: self.indexPath)
            }
            self.touchDeeplink = false
        }
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension FillCheckListCell : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.markdownWebView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: ((WKNavigationActionPolicy) -> Void)) {
        
        switch navigationAction.navigationType {
        case .linkActivated:
            if navigationAction.request.url?.scheme == "umbrella" {
                print(Date())
                self.touchDeeplink = true
                UIApplication.shared.open(navigationAction.request.url!)
            } else {
                if (navigationAction.request.url?.scheme?.contains("http"))! {
//                    let safariViewController = SFSafariViewController(url: navigationAction.request.url!)
//                    safariViewController.delegate = self
//                    UIApplication.shared.delegate!.window?!.rootViewController!.present(safariViewController, animated: true)
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

//extension FillCheckListCell: SFSafariViewControllerDelegate {
//    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        dismiss(animated: true)
//    }
//}
