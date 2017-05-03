//
//  SpringContentView.swift
//  TableViewScrolling
//
//  Created by Pawel Kowalczuk on 02/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import UIKit

class SpringContentView: UIView {
    
    fileprivate var rectFrame = CAShapeLayer()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
        rectFrame.path = UIBezierPath(rect: frame).cgPath
        rectFrame.strokeColor = UIColor.random.cgColor
        rectFrame.lineWidth = 1.0
        rectFrame.fillColor = rectFrame.strokeColor
        layer.addSublayer(rectFrame)
        
//        let path = UIBezierPath()
//        path.move(to: center)
//        path.addLine(to: CGPoint(x: center.x, y: -center.y))
//        
//        let line = CAShapeLayer()
//        line.path = path.cgPath
//        line.strokeColor = rectFrame.strokeColor
//        line.lineWidth = 5.0
//        line.fillColor = UIColor.clear.cgColor
//        layer.addSublayer(line)
//        layer.masksToBounds = false
//        clipsToBounds = false
    }
    
    func draw(with velocity: CGFloat, directionUp: Bool) {
        
        guard velocity != 0.0 else {
            rectFrame.path = UIBezierPath(rect: frame).cgPath
            return
        }
        
        let kMAXLE_Y: CGFloat = 40.0
        let max_le_y = min(velocity, kMAXLE_Y)
        let diff: CGFloat = 33.0
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
}
