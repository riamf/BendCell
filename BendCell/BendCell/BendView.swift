//
//  BendView.swift
//  BendCell
//
//  Created by Pawel Kowalczuk on 03/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import UIKit

class BendView: UIView {
    
    fileprivate var rectFrame = CAShapeLayer()
    fileprivate var originalColor: UIColor
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Should not be initialized this way!")
    }
    
    init(frame: CGRect, color: UIColor) {
        originalColor = color
        super.init(frame: frame)
        backgroundColor = nil
        addRectFrame()
    }
    
    func update(_ color: UIColor) {
        originalColor = color
        rectFrame.fillColor = color.cgColor
        rectFrame.strokeColor = color.cgColor
    }
    
    override var frame: CGRect {
        didSet {
            rectFrame.path = UIBezierPath(rect: frame).cgPath
        }
    }
    
    fileprivate func addRectFrame() {
        rectFrame.path = UIBezierPath(rect: frame).cgPath
        rectFrame.strokeColor = originalColor.cgColor
        rectFrame.lineWidth = 1.0
        rectFrame.fillColor = rectFrame.strokeColor
        layer.addSublayer(rectFrame)
    }
    
    func draw(with velocity: CGFloat, directionUp: Bool) {
        
        guard velocity != 0.0 else {
            rectFrame.path = UIBezierPath(rect: frame).cgPath
            return
        }
        
        let kMAXLE_Y: CGFloat = 20.0
        let max_le_y = min(velocity, kMAXLE_Y)
        let diff: CGFloat = frame.size.width * 0.33
        let le_y: CGFloat = directionUp ? -max_le_y : max_le_y
        
        let path = UIBezierPath()
        path.move(to: .zero)
        let ctrl1 = CGPoint(x:diff, y: le_y)
        let ctrl2 = CGPoint(x: frame.size.width - diff, y: le_y)
        path.addCurve(to: CGPoint(x:frame.size.width, y: 0.0), controlPoint1: ctrl1, controlPoint2: ctrl2)
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height))
        
        let ctrl3 = CGPoint(x: frame.size.width - diff, y: frame.size.height + le_y)
        let ctrl4 = CGPoint(x: diff, y: frame.size.height + le_y)
        path.addCurve(to: CGPoint(x: 0.0, y: frame.size.height), controlPoint1: ctrl3, controlPoint2: ctrl4)
        path.addLine(to: .zero)
        path.close()
        
        rectFrame.path = path.cgPath
    }
    
    func applyResizing(with offset: CGFloat) {
        guard offset <= 0.0 else { return }
        
        var computedFrame = frame
        computedFrame.origin.y = offset
        computedFrame.size.height += -offset
        frame = computedFrame
    }
}
