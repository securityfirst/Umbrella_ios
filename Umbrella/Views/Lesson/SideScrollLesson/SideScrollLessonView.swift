//
//  SideScrollLesson.swift
//  SideScroll
//
//  Created by Lucas Correa on 09/10/2018.
//  Copyright © 2018 Lucas Correa. All rights reserved.
//

import UIKit

protocol SideScrollLessonViewDataSource {
    func viewAtIndex(_ index: Int) -> UIView
    func numberOfTitles() -> Int
}

class SideScrollLessonView: UIView, UIScrollViewDelegate {
    
    //
    // MARK: - Properties
    var dataSource: SideScrollLessonViewDataSource!
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
    
    fileprivate var percentualView: CGFloat = 50
    fileprivate var scrollView: UIScrollView!
    fileprivate var progressBar: UIProgressView!
    fileprivate var progressLabel: UILabel!
    fileprivate var pageIndicator: UIView!
    
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
        
        // I needed to use UIView.animate because if I use with contentOffSet the animate is not done with synchronized.
        //self.scrollView.setContentOffset(CGPoint(x: page * (self.frame.size.width * percentualView)/100, y: 0), animated: true)
        let width = self.frame.size.width
        let pageSize = page * self.visivelPercentualSize
        
        var xFinal:CGFloat = 0.0
        
        if page != 0 || Int(page) == self.totalViewCount {
            xFinal = pageSize - (width - self.visivelPercentualSize)/2
        } else {
            xFinal = pageSize
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                self.scrollView.contentOffset.x = xFinal
            }, completion: nil)
            
            UIView.animate(withDuration: 0.2, delay: 0.1, options: [.curveEaseOut, .beginFromCurrentState], animations: {
                var rect = self.pageIndicator.frame
                rect.size.width = self.viewWidth(index: Int(page))
                self.pageIndicator.frame = rect
                
                self.pageIndicator.frame.origin.x = pageSize
            }, completion: nil)
        }
    }
    
    /// The Method return width of view of the title for the index
    ///
    /// - Parameter index: Index
    /// - Returns: Width
    func viewWidth(index: Int) -> CGFloat {
        return visivelPercentualSize
    }
    
    /// Change the state of the title to .active, .done or .inactive
    fileprivate func changeState() {
        
        for view in self.scrollView.subviews {
            
            var stepperItem = view as? SideScrollProtocol
            
            if let index = stepperItem?.index {
                if index == currentIndex {
                    stepperItem?.stage = .active
                } else {
                    stepperItem?.stage = .inactive
                }
            }
        }
    }
    
    /// Rearrange the views of the titles
    fileprivate func reArrangeViews() {
        var totalWidth: CGFloat = 0.0
        
        for index in 0..<totalViewCount {
            
            let itemView = dataSource.viewAtIndex(index)
            
            if var view = itemView as? SideScrollProtocol {
                view.stage = index == 0 ? .active : .inactive
                view.index = index
            } else {
                fatalError("CustomView must implement the StepperProtocol")
            }
            
            self.pageIndicator.frame = CGRect(x: 0, y: self.frame.size.height - 2.5, width: self.visivelPercentualSize, height: 2.5)
            self.scrollView.addSubview(itemView)
            self.scrollView.addSubview(self.pageIndicator)
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
        
        // page indicator
        self.pageIndicator = UIView()
        self.pageIndicator.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.2117647059, blue: 0.3411764706, alpha: 1)
        self.pageIndicator.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        self.scrollView.addSubview(self.pageIndicator)
    }
}
