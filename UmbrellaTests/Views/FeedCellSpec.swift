//
//  FeedCellSpec.swift
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

class FeedCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("FeedCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(FeedCell.self, forCellReuseIdentifier: "FeedCell")
            }
            
            it("should create a new FeedCell") {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell")
                cell?.awakeFromNib()
                expect(cell).toNot(beNil())
            }
            
            it("should configure cell") {
                let cell: FeedCell = (tableView.dequeueReusableCell(withIdentifier: "FeedCell") as? FeedCell)!
                cell.awakeFromNib()
                
                let feedViewModel = FeedViewModel()
                
                let feedItem = FeedItem()
                feedItem.title = "UNHCR: Yemen UNHCR Update, 13 - 26 October 2018"
                feedItem.description = "<p><strong>Situation Update</strong></p>"
                feedItem.url = "https://reliefweb.int/node/2849848"
                feedItem.updatedAt = 1540997135
                
                feedViewModel.feedItems = [feedItem]
                
                cell.configure(withViewModel: feedViewModel, indexPath: IndexPath(row: 0, section: 0))
                expect(cell).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
