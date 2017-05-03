//
//  ViewController.swift
//  TableViewScrolling
//
//  Created by Pawel Kowalczuk on 01/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var table: UITableView!
    fileprivate var lastOffset: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 17
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ClearCell") else {
            fatalError("Table has no cell registered.")
        }

        return cell
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let directionUp = scrollView.contentOffset.y > lastOffset
        let velocity: CGFloat = abs(lastOffset - scrollView.contentOffset.y)
        table.visibleCells.forEach({ ($0 as? ClearCell)?.draw(with: velocity, directionUp: directionUp)})
        lastOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        lastOffset = scrollView.contentOffset.y
        table.visibleCells.forEach({ ($0 as? ClearCell)?.draw(with: 0.0, directionUp: true)})
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        lastOffset = scrollView.contentOffset.y
        table.visibleCells.forEach({ ($0 as? ClearCell)?.draw(with: 0.0, directionUp: true)})
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        lastOffset = scrollView.contentOffset.y
        table.visibleCells.forEach({ ($0 as? ClearCell)?.draw(with: 0.0, directionUp: true)})
    }
}
