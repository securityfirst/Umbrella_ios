//
//  NewCheckItemCellSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 14/12/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import Umbrella

class NewCheckItemCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("NewCheckItemCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(NewCheckItemCell.self, forCellReuseIdentifier: "NewCheckItemCell")
            }
            
            describe(".viewDidLoad") {
                it("should create a new NewCheckItemCell") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "NewCheckItemCell")
                    cell?.awakeFromNib()
                    expect(cell).toNot(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
