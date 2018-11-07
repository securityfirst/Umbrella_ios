//
//  DifficultyCellSpec.swift
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

class DifficultyCellSpec: QuickSpec {
    
    override func spec() {
        
        var tableView: UITableView!
        
        describe("DifficultyCell") {
            
            beforeEach {
                tableView = UITableView()
                tableView.register(DifficultyCell.self, forCellReuseIdentifier: "DifficultyCell")
            }
            
            describe(".viewDidLoad") {
                it("should create a new DifficultyCell") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DifficultyCell")
                    cell?.awakeFromNib()
                    expect(cell).toNot(beNil())
                }
            }
            
            describe(".layoutSubviews") {
                it("should create a new DifficultyCell") {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "DifficultyCell")
                    cell?.layoutSubviews()
                    expect(cell).toNot(beNil())
                }
            }
            
            afterEach {
                
            }
        }
    }
}
