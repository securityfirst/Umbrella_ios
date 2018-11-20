//
//  SettingCellSpec.swift
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

class SettingCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("SettingCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(SettingCell.self, forCellReuseIdentifier: "SettingCell")
            }
            
            describe(".viewDidLoad") {
                it("should create a new SettingCell") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell")
                    cell?.awakeFromNib()
                    expect(cell).toNot(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
