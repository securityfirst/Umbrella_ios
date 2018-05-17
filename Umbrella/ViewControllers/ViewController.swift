//
//  ViewController.swift
//  Umbrella
//
//  Created by Lucas Correa on 15/05/2018.
//  Copyright © 2018 Security First. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let ret:[Category] = SQLManager.shared.select(withQuery: "SELECT category, parent, difficultyAdvanced FROM category")
//        print(ret)
        
//        _ = SQLManager.shared.drop(tableName: "category")
        
//        _ = SQLManager.shared.create(table: Category(name: "test", tableName: "category"))
        
//        _ = SQLManager.shared.insert(withQuery: "INSERT INTO category ('category', 'difficultyAdvanced', 'difficultyBeginner', 'difficultyExpert', 'hasDifficulty', 'parent', 'textAdvanced', 'textBeginner', 'textExpert') VALUES ('Categoria Test', 0, 0, 0, 0, 0, 'Teste 1', 'Teste 2', 'Teste 3')")
//        let ret2:[Category] = SQLManager.shared.select(withQuery: "SELECT category, parent, difficultyAdvanced FROM category")
//        print(ret2)
        
//        let ret2:[CheckItem] = SQLManager.shared.select(withQuery: "SELECT category, custom FROM checkitem")
//        print(ret2)
    }

}
