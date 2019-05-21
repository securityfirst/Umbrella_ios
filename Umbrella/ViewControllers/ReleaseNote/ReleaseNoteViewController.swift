//
//  ReleaseNoteViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 20/05/2019.
//  Copyright © 2019 Security First. All rights reserved.
//

import UIKit

class ReleaseNoteViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let language: String = UserDefaults.standard.object(forKey: "Language") as? String ?? "en"
        // Arabic(ar) or Persian Farsi(fa)
        if language == "ar" || language == "fa" {
            self.noteTextView.textAlignment = .right
        } else {
            self.noteTextView.textAlignment = .left
        }
        
        self.titleLabel.text = "What is new?".localized()
        
        guard let filepath = Bundle.main.path(forResource: "releasenote", ofType: "json") else { return }
        do {
            let contents = try String(contentsOfFile: filepath)
            let object = try JSONSerialization.jsonObject(with: contents.data(using: .utf16)!, options: [.mutableContainers, .allowFragments])
            
            if let object = object as? [String : AnyObject] {
                if let releaseNote = object[language]?["releasenote"] as? String {
                    self.noteTextView.text = releaseNote                    
                }
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func okAction(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}
