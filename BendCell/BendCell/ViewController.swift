//
//  ViewController.swift
//  TableViewScrolling
//
//  Created by Pawel Kowalczuk on 01/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit


class BendableTableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    private var lastOffset: CGFloat = 0.0
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let directionUp = scrollView.contentOffset.y > lastOffset
        let velocity: CGFloat = abs(lastOffset - scrollView.contentOffset.y)
        table.visibleCells.forEach({ ($0 as? BendableCellType)?.draw(with: velocity, directionUp: directionUp)})
        lastOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        lastOffset = scrollView.contentOffset.y
        table.visibleCells.forEach({ ($0 as? BendableCellType)?.draw(with: 0.0, directionUp: true)})
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastOffset = scrollView.contentOffset.y
        table.visibleCells.forEach({ ($0 as? BendableCellType)?.draw(with: 0.0, directionUp: true)})
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        lastOffset = scrollView.contentOffset.y
        table.visibleCells.forEach({ ($0 as? BendableCellType)?.draw(with: 0.0, directionUp: true)})
    }
}

class ViewController: BendableTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        return cell
    }
}
