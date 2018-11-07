//
//  CheckListLabelCellSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 06/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import Umbrella

class CheckListLabelCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("CheckListLabelCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(CheckListLabelCell.self, forCellReuseIdentifier: "CheckListLabelCell")
            }
            
            describe(".viewDidLoad") {
                it("should create a new CheckListLabelCell") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListLabelCell")
                    cell?.awakeFromNib()
                    expect(cell).toNot(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
