//
//  BendableCell.swift
//  BendCell
//
//  Created by Pawel Kowalczuk on 03/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import UIKit

protocol BendableCellType {
    var bendView: BendView? { get }
    func draw(with velocity: CGFloat, directionUp: Bool)
}

extension BendableCellType where Self: UITableViewCell {
    
    func draw(with velocity: CGFloat, directionUp: Bool) {
        bendView?.draw(with: velocity, directionUp: directionUp)
    }
}

class BendableCell: UITableViewCell, BendableCellType {
    
    var bendView: BendView?
    
    fileprivate func initialize() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        addBendView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    fileprivate func addBendView() {
        
        let view = BendView(frame: frame)
        contentView.addSubview(view)
        bendView = view
    }
}
