//
//  SettingItemCellSpec.swift
//  UmbrellaTests
//
//  Created by Lucas Correa on 21/11/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble

@testable import Umbrella

class SettingItemCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("SettingItemCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(SettingItemCell.self, forCellReuseIdentifier: "SettingItemCell")
            }
            
            describe(".viewDidLoad") {
                it("should create a new SettingItemCell") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SettingItemCell")
                    cell?.awakeFromNib()
                    expect(cell).toNot(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
