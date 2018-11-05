//
//  FillCheckListCellSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 02/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Umbrella

class FillCheckListCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("FillCheckListCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(FillCheckListCell.self, forCellReuseIdentifier: "FillCheckListCell")
            }
            
            it("should create a new FillCheckListCell") {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FillCheckListCell")
                cell?.awakeFromNib()
                expect(cell).toNot(beNil())
            }
            
            afterEach {
                
            }
        }
    }
}
