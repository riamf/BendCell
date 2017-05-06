//
//  BendableTableViewController.swift
//  BendCell
//
//  Created by Pawel Kowalczuk on 04/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit

open class BendableTableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    private var lastOffset: CGFloat = 0.0
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let directionUp = scrollView.contentOffset.y > lastOffset
        let velocity: CGFloat = abs(lastOffset - scrollView.contentOffset.y)
        table.visibleCells.forEach({
            ($0 as? BendableCellType)?.draw(with: velocity, directionUp: directionUp)
        })
        lastOffset = scrollView.contentOffset.y
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        lastOffset = scrollView.contentOffset.y
        table.visibleCells.forEach({ ($0 as? BendableCellType)?.draw(with: 0.0, directionUp: true)})
    }
    
    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastOffset = scrollView.contentOffset.y
        table.visibleCells.forEach({ ($0 as? BendableCellType)?.draw(with: 0.0, directionUp: true)})
    }
    
    open func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        lastOffset = scrollView.contentOffset.y
        table.visibleCells.forEach({ ($0 as? BendableCellType)?.draw(with: 0.0, directionUp: true)})
    }
}
