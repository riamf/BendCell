//
//  ViewController.swift
//  TableViewScrolling
//
//  Created by Pawel Kowalczuk on 01/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit

class ViewController: BendableTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(MyTableViewCell.self, forCellReuseIdentifier: "MyTableViewCell")
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: UITableViewDataSource {
    
    enum Table {
        static let sections: Int = 1
        static let rows: Int = 17
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return Table.sections
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Table.rows
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = indexPath.row % 2 == 0 ? "XibCell" : "MyTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID) else {
            fatalError("Table has no cell registered.")
        }
        return cell
    }
}
