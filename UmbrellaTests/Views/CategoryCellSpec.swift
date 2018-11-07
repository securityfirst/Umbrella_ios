//
//  CategoryCellSpec.swift
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

class CategoryCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("CategoryCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(CategoryCell.self, forCellReuseIdentifier: "CategoryCell")
            }
            
            describe(".viewDidLoad") {
                it("should create a new CategoryCell") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell")
                    cell?.awakeFromNib()
                    expect(cell).toNot(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
