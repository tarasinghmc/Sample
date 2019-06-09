//
//  BubbleView.swift
//  Bubble
//
//  Created by Tara Singh M C on 05/06/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit
class BubbleView: UIView {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let bubbleColor = UIColor.red
        bubbleColor.setStroke()
        bubbleColor.setFill()
        
        let bubbleSpace = CGRect(x: rect.minX, y: rect.minY, width: rect.maxX, height: rect.maxY)
        
        let bubblePath = UIBezierPath(roundedRect: bubbleSpace, cornerRadius: rect.midY)
        bubblePath.stroke()
        bubblePath.fill()
        
        
        let tailPath = UIBezierPath()
        tailPath.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        tailPath.addQuadCurve(to: CGPoint(x: 32.0, y: rect.midY), controlPoint: CGPoint(x: 8.0, y: rect.maxY-8.0))
        tailPath.addLine(to: CGPoint(x: 64.0, y: rect.midY))
        tailPath.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), controlPoint: CGPoint(x: 32.0, y: rect.maxY-8.0))
        
        tailPath.stroke()
        tailPath.fill()
    }
    
    
}

//class BubbleView: UIView {
//
//
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        let bubbleColor = UIColor.red
//        bubbleColor.setStroke()
//        bubbleColor.setFill()
//
//        let bubbleSpace = CGRect(x: 16.0, y: rect.minY + 2.0, width: rect.maxX - 18.0, height: rect.maxY - 4.0)
//
//        let bubblePath = UIBezierPath(roundedRect: bubbleSpace, cornerRadius: rect.midY)
//        bubblePath.stroke()
//        bubblePath.fill()
//
//        let tailPath = UIBezierPath()
//        tailPath.move(to: CGPoint(x: rect.minX, y: rect.maxY))
//        tailPath.addQuadCurve(to: CGPoint(x: 32.0, y: rect.midY), controlPoint: CGPoint(x: 8.0, y: rect.maxY-8.0))
//        tailPath.addLine(to: CGPoint(x: 64.0, y: rect.midY))
//         tailPath.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), controlPoint: CGPoint(x: 32.0, y: rect.maxY-8.0))
//
//        tailPath.stroke()
//        tailPath.fill()
//    }
//
//
//}
