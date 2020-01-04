//
//  Dots.swift
//  DotAnimation
//
//  Created by Tara Singh M C on 04/01/20.
//  Copyright © 2020 Tara Singh. All rights reserved.
//

import UIKit

class Dots: UIView, CAAnimationDelegate {
    
    enum AnimationType: String {
        case up = "up"
        case down = "down"
    }
    var invalidate: Bool = false
    private var caLayer: CALayer = CALayer()
    var dotColor = UIColor.black {
        didSet {
            caLayer.backgroundColor = dotColor.cgColor
        }
    }
    
    private var replicator: CAReplicatorLayer {
        get {
            return layer as! CAReplicatorLayer
        }
    }
    
    override class var layerClass: AnyClass {
          get {
              return CAReplicatorLayer.self
          }
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .green
        //Replicator
        replicator.backgroundColor = UIColor.clear.cgColor
        replicator.instanceCount = 3
        replicator.instanceTransform = CATransform3DMakeTranslation(dotSize() * 1.6, 0.0, 0.0)
        replicator.instanceDelay = 0.1
        
        //Layer
        caLayer = CALayer()
        caLayer.bounds = CGRect(x: 0.0, y: 0.0, width: dotSize(), height: dotSize())
        caLayer.position = CGPoint(x: center.x - (dotSize() * 1.6), y: center.y + (dotSize() * 0.2))
        caLayer.cornerRadius = dotSize() / 2
        caLayer.backgroundColor = dotColor.cgColor
        
        replicator.addSublayer(caLayer)
        //animationStart()
    }
    
    func dotSize() -> CGFloat {
        return self.frame.size.height / 5
    }
    
    // Animations
    
    func createAnimation(keyPath:AnimationKeyPath, fromValue:CGFloat, toValue:CGFloat, duration:CFTimeInterval) -> CASpringAnimation{
        let animation = CASpringAnimation(keyPath: keyPath.rawValue)
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards;
        return animation
    }
    
    func animationGroup(duration:CFTimeInterval, name:String, animations:[CASpringAnimation]) -> CAAnimationGroup {
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = animations
        animationGroup.duration = duration
        animationGroup.setValue(name, forKey: "animation")
        animationGroup.delegate = self
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = CAMediaTimingFillMode.forwards;
        return animationGroup
    }
    
    func animationStart() {
        let move = createAnimation(keyPath: .yPosition, fromValue:caLayer.position.y, toValue: caLayer.position.y - dotSize(), duration: 0.5)
        let alpha = createAnimation(keyPath: .opacity, fromValue: 1.0, toValue: 0.0, duration: 0.5)
        let scale = createAnimation(keyPath: .scale, fromValue: 1.0, toValue: 1.3, duration: 0.5)
        let anim = animationGroup(duration: 0.5, name: AnimationType.up.rawValue, animations: [move, alpha, scale])
        caLayer.add(anim, forKey: nil)
    }
    
    func animationEnd() {
        let move = createAnimation(keyPath: .yPosition, fromValue:caLayer.position.y + 5, toValue:caLayer.position.y, duration:0.2)
        let alpha = createAnimation(keyPath: .opacity, fromValue: 0.0, toValue: 1.0, duration: 0.5)
        let scale = createAnimation(keyPath: .scale, fromValue: 0.5, toValue: 1.0, duration: 0.3)
        let anim = animationGroup(duration: 0.7, name: "down", animations: [move, alpha, scale])
        caLayer.add(anim, forKey: nil)
    }

    // Animation Delegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard !self.invalidate else {
            return
        }
        if (anim.value(forKey: "animation") as! String == "up") {
            print("Animation Up")
            animationEnd()
        } else if (anim.value(forKey: "animation") as! String == "down") {
            print("Animation Start")
            animationStart()
        }
    }
    
    func invalidateAnimation() {
        self.caLayer.removeAllAnimations()
        self.invalidate = true
    }
}



enum AnimationKeyPath:String {
    case
    scale        = "transform.scale",
    yPosition    = "position.y",
    opacity      = "opacity"
}
