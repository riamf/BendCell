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

open class BendableCell: UITableViewCell, BendableCellType {
    
    var bendView: BendView?
    fileprivate var originalColor: UIColor!
    
    fileprivate func initialize() {
        
        originalColor = contentView.backgroundColor ?? .random
        backgroundColor =  nil
        contentView.backgroundColor = nil
        addBendView()
        addObservers()
    }
    
    fileprivate func updateIfNeeded(with color: UIColor) {
        bendView?.update(color)
        contentView.backgroundColor = nil
    }
    
    fileprivate func replaceBendViewIfNeeded() {
        guard let bendViewIndex = contentView.subviews.index(where: { $0 === bendView }),
            bendViewIndex != 0 else { return }
        bendView?.removeFromSuperview()
        contentView.insertSubview(bendView!, at: 0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        bendView?.frame = CGRect(origin: .zero, size: frame.size)
    }
    
    fileprivate func addBendView() {
        
        let view = BendView(frame: frame, color: originalColor)
        contentView.addSubview(view)
        bendView = view
    }
    
    //MARK: KVO
    
    enum Observerable {
        static let color: String = #keyPath(contentView.backgroundColor)
        static let subviews: String = #keyPath(contentView.subviews)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let color = change?[NSKeyValueChangeKey.newKey] as? UIColor {
            updateIfNeeded(with: color)
        }
        if keyPath == #keyPath(contentView.subviews) {
            replaceBendViewIfNeeded()
        }
    }
    
    fileprivate func addObservers() {
        addObserver(self, forKeyPath: Observerable.color, options: .new, context: nil)
        addObserver(self, forKeyPath: Observerable.subviews, options: .initial, context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: Observerable.color, context: nil)
        removeObserver(self, forKeyPath: Observerable.subviews, context: nil)
    }
}

extension UIColor {
    static var random: UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
}
