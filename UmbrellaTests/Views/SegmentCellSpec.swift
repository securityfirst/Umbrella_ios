//
//  SegmentCellSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 02/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import Umbrella

class SegmentCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UICollectionView!
        
        describe("SegmentCell") {
            
            beforeEach {
                tableView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
                tableView.register(SegmentCell.self, forCellWithReuseIdentifier: "SegmentCell")
            }
            
            it("should create a new SegmentCell") {
                let cell = tableView.dequeueReusableCell(withReuseIdentifier: "SegmentCell", for: IndexPath(row: 0, section: 0))
                cell.awakeFromNib()
                expect(cell).toNot(beNil())
            }

            it("should create a new SegmentCell") {
                let cell = tableView.dequeueReusableCell(withReuseIdentifier: "SegmentCell", for: IndexPath(row: 0, section: 0))
                cell.layoutSubviews()
                expect(cell).toNot(beNil())
            }
            
            it("should configure cell") {
                let indexPath = IndexPath(row: 0, section: 0)
                let cell: SegmentCell = (tableView.dequeueReusableCell(withReuseIdentifier: "SegmentCell", for: indexPath) as? SegmentCell)!
                cell.awakeFromNib()
                
                let segmentViewModel = SegmentViewModel()
                
                let category = Category(name: "Tools", description: "Description", index: 0)
                category.segments = [Segment(name: "Segment test", index: 1.0, content: "## Title")]
                segmentViewModel.difficulty = category
                
                cell.configure(withViewModel: segmentViewModel, indexPath: indexPath)
                expect(cell).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
