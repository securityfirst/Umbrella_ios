//
//  FeedCellSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 02/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
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
            
            afterEach {
                
            }
        }
    }
}
