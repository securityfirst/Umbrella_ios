//
//  AccountCellSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 19/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import Umbrella

class AccountCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("AccountCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(AccountCell.self, forCellReuseIdentifier: "AccountCell")
            }
            
            describe(".viewDidLoad") {
                it("should create a new AccountCell") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell")
                    cell?.awakeFromNib()
                    expect(cell).toNot(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
