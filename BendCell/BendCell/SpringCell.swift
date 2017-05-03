//
//  SpringCell.swift
//  TableViewScrolling
//
//  Created by Pawel Kowalczuk on 01/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import UIKit

class ClearCell: UITableViewCell {
    
    @IBOutlet private weak var springView: SpringContentView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func draw(with velocity: CGFloat, directionUp: Bool) {
        springView.draw(with: velocity, directionUp: directionUp)
    }
}
