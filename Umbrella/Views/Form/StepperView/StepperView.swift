//
//  StepperView.swift
//  Umbrella
//
//  Created by Lucas Correa on 10/07/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit

protocol StepperViewDataSource {
    func viewAtIndex(_ index: Int) -> UIView
    func numberOfTitles() -> Int
}

class StepperView: UIView, UIScrollViewDelegate {
    
    //
    // MARK: - Properties
    var dataSource: StepperViewDataSource!
    var visivelPercentualSize: CGFloat {
        return (self.frame.size.width * percentualView)/100
    }
    
    var progressTintColor = #colorLiteral(red: 0.5934140086, green: 0.7741840482, blue: 0.2622931898, alpha: 1) {
        didSet {
            progressBar.progressTintColor = progressTintColor
        }
    }
    
    var trackTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            progressBar.trackTintColor = trackTintColor
        }
    }
    
    var totalViewCount: Int = 0
    var currentIndex: Int = 0
    
    fileprivate var percentualView: CGFloat = 75
    fileprivate var scrollView: UIScrollView!
    fileprivate var progressBar: UIProgressView!
    fileprivate var progressLabel: UILabel!
    
    //
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    //
    // MARK: - Functions
    
    /// Refresh and reload the data
    func reloadData() {
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        
        totalViewCount = dataSource.numberOfTitles()
        reArrangeViews()
    }
    
    /// When the title is change this method receive the current page and change the position of the title
    ///
    /// - Parameter page: Current page
    func scrollViewDidPage(page: CGFloat) {
        
        currentIndex = Int(page)
        changeState()
        updateProgress()
        
        // I needed to use UIView.animate because if I use with contentOffSet the animate is not done with synchronized.
        //self.scrollView.setContentOffset(CGPoint(x: page * (self.frame.size.width * percentualView)/100, y: 0), animated: true)
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                self.scrollView.contentOffset.x = page * (self.frame.size.width * self.percentualView)/100
            }, completion: nil)
        }
    }
    
    /// The Method return width of view of the title for the index
    ///
    /// - Parameter index: Index
    /// - Returns: Width
    func viewWidth(index: Int) -> CGFloat {
        var width: CGFloat = 0.0
        if index == totalViewCount - 1 {
            width = self.frame.size.width
        } else {
            width = visivelPercentualSize
        }
        return width
    }
    
    /// Change the state of the title to .active, .done or .inactive
    fileprivate func changeState() {
        
        for view in self.scrollView.subviews {
            
            var stepperItem = view as? StepperProtocol
            
            if let index = stepperItem?.index {
                if index == currentIndex {
                    stepperItem?.stage = .active
                } else if index < currentIndex {
                    stepperItem?.stage = .done
                } else {
                    stepperItem?.stage = .inactive
                    stepperItem?.index = index
                }
            }
        }
    }
    
    /// Update the progress of the progressBar
    fileprivate func updateProgress() {
        self.progressBar.setProgress(Float(currentIndex)/Float(totalViewCount - 1), animated: true)
        self.progressLabel.text = "\(Int(CGFloat(currentIndex) / CGFloat(totalViewCount - 1) * 100))%"
    }
    
    /// Rearrange the views of the titles
    fileprivate func reArrangeViews() {
        var totalWidth: CGFloat = 0.0
        
        for index in 0..<totalViewCount {
            
            let itemView = dataSource.viewAtIndex(index)
            
            if var view = itemView as? StepperProtocol {
                view.index = index
                view.stage = index == 0 ? .active : .inactive
            } else {
                fatalError("CustomView must implement the StepperProtocol")
            }
            scrollView.addSubview(itemView)
            totalWidth += itemView.frame.size.width
        }
        
        self.scrollView.contentSize = CGSize(width: totalWidth, height: self.frame.size.height)
    }
    
    /// Create the scrollView and progressBar
    fileprivate func setup() {
        self.scrollView = UIScrollView(frame: self.bounds)
        self.scrollView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.scrollView.delegate = self
        self.scrollView.clipsToBounds = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.addSubview(self.scrollView)
        
        // ProgressBarView
        self.progressBar = UIProgressView(frame: CGRect(x: 0, y: self.frame.size.height-12, width: self.frame.size.width, height: 2))
        self.progressBar.progressTintColor = progressTintColor
        self.progressBar.trackTintColor = trackTintColor
        self.addSubview(progressBar)
        
        // ProgressBar Label
        self.progressLabel = UILabel(frame: CGRect(x: 0, y: self.frame.size.height-10, width: self.frame.size.width, height: 12))
        self.progressLabel.textAlignment = .center
        self.progressLabel.textColor = progressTintColor
        self.progressLabel.text = "0%"
        self.progressLabel.font = UIFont(name: "Roboto-Bold", size: 8)
        self.addSubview(progressLabel)
    }
    
    func updateFrame() {
        self.scrollView.frame = self.bounds
        self.progressBar.frame = CGRect(x: 0, y: self.frame.size.height-12, width: self.frame.size.width, height: 2)
        self.progressLabel.frame = CGRect(x: 0, y: self.frame.size.height-10, width: self.frame.size.width, height: 12)
    }
}
