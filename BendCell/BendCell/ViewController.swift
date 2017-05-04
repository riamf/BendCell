//
//  ViewController.swift
//  TableViewScrolling
//
//  Created by Pawel Kowalczuk on 01/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit

class MyTableView: BendableCell {
    
    
}

class ViewController: BendableTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(MyTableView.self, forCellReuseIdentifier: "MyTableView")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 17
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BendableCell") else {
            fatalError("Table has no cell registered.")
        }

        cell.contentView.backgroundColor = UIColor.random
        return cell
    }
}
