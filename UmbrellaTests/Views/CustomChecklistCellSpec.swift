//
//  CustomChecklistCellSpec.swift
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

class CustomChecklistCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("CustomChecklistCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(CustomChecklistCell.self, forCellReuseIdentifier: "CustomChecklistCell")
            }
            
            describe(".viewDidLoad") {
                it("should create a new CustomChecklistCell") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CustomChecklistCell")
                    cell?.awakeFromNib()
                    expect(cell).toNot(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
