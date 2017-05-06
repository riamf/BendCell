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
    
    enum Constants {
        static let MaxY: CGFloat = 20.0
        static let point3: CGFloat = 0.33
    }
    
    fileprivate var rectFrame = CAShapeLayer()
    fileprivate var originalColor: UIColor
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Should not be initialized this way!")
    }
    
    override init(frame: CGRect) {
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
        
        let maxY = min(velocity, Constants.MaxY)
        let pThirdWidth: CGFloat = frame.size.width * Constants.point3
        let maxYWithDirection: CGFloat = directionUp ? -maxY : maxY
        
        let path = UIBezierPath()
        path.move(to: .zero)
        let ctrlPoint1 = CGPoint(x: pThirdWidth, y: maxYWithDirection)
        let ctrlPoint2 = CGPoint(x: frame.size.width - pThirdWidth, y: maxYWithDirection)
        path.addCurve(to: CGPoint(x:frame.size.width, y: 0.0),
                      controlPoint1: ctrlPoint1, controlPoint2: ctrlPoint2)
        path.addLine(to: CGPoint(x: frame.size.width, y: frame.size.height))
        
        let ctrlPoint3 = CGPoint(x: frame.size.width - pThirdWidth,
                                 y: frame.size.height + maxYWithDirection)
        let ctrlPoint4 = CGPoint(x: pThirdWidth, y: frame.size.height + maxYWithDirection)
        path.addCurve(to: CGPoint(x: 0.0, y: frame.size.height),
                      controlPoint1: ctrlPoint3, controlPoint2: ctrlPoint4)
        path.addLine(to: .zero)
        path.close()
        
        rectFrame.path = path.cgPath
    }
}
