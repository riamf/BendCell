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
    func applyResizing(with offset: CGFloat)
}

extension BendableCellType where Self: UITableViewCell {
    
    func draw(with velocity: CGFloat, directionUp: Bool) {
        bendView?.draw(with: velocity, directionUp: directionUp)
    }
    
    func applyResizing(with offset: CGFloat) {
        bendView?.applyResizing(with: offset)
    }
}

class BendableCell: UITableViewCell, BendableCellType {
    
    var bendView: BendView?
    fileprivate var originalColor: UIColor!
    
    fileprivate func initialize() {
        originalColor = contentView.backgroundColor ?? .random
        backgroundColor =  nil
        contentView.backgroundColor = nil
        addBendView()
        addObserver(self, forKeyPath: #keyPath(contentView.backgroundColor), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let color = change?[NSKeyValueChangeKey.newKey] as? UIColor {
            bendView?.update(color)
            contentView.backgroundColor = nil
        }
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(contentView.backgroundColor), context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bendView?.frame = CGRect(origin: .zero, size: frame.size)
    }
    
    fileprivate func addBendView() {
        
        let view = BendView(frame: frame, color: originalColor)
        contentView.addSubview(view)
        bendView = view
    }
}

extension UIColor {
    static var random: UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}
