//
//  ViewController.swift
//  animations
//
//  Created by ani kvitsiani on 12.11.23.
//

import UIKit

class ViewController: UIViewController {
    
    
    let textLayer = CATextLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        textLayer.string = "TBC IT Academy"
        let text = textLayer.string
        textLayer.fontSize = 20
        textLayer.font = UIFont.boldSystemFont(ofSize: textLayer.fontSize)
        textLayer.foregroundColor = UIColor.blue.cgColor
        textLayer.backgroundColor = UIColor.white.cgColor
        
        let textWidth = widthOfString(text as! String, fontSize: 28)
        
        
        //რატომთაც 20ს როცა ვუთითებდი ადგილს ტოვებდა და არ ავსებდა ჩარჩოს, ამიტომ ჩავწერე 28:)
        
        textLayer.alignmentMode = .center
        textLayer.frame = CGRect(x: view.bounds.width/2-textWidth/2, y: view.bounds.height/2-25, width: textWidth, height: 50)
        
    
        
        view.layer.addSublayer(textLayer)
        animateMovementAndOpacity()
        
        
        
    }
    
    
    func widthOfString(_ string: String, fontSize: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (string as NSString).size(withAttributes: fontAttributes)
        return ceil(size.width)
    }
    
    
    
    func animateMovementAndOpacity(){
        let moveAnimation = CABasicAnimation(keyPath: "position")
        moveAnimation.fromValue = CGPoint(x: textLayer.position.x, y: textLayer.position.y + 60)
        moveAnimation.toValue = CGPoint(x: textLayer.position.x, y: textLayer.position.y)
        moveAnimation.duration = 2
        moveAnimation.fillMode = .forwards
        moveAnimation.isRemovedOnCompletion = false
        moveAnimation.beginTime = CACurrentMediaTime()
        textLayer.add(moveAnimation, forKey: nil)
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0
        opacityAnimation.toValue = 1
        opacityAnimation.duration = 2
        opacityAnimation.fillMode = .forwards
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.beginTime = CACurrentMediaTime()
        textLayer.add(opacityAnimation, forKey: nil)
        
        
        
        let group = CAAnimationGroup()
        group.animations = [moveAnimation, opacityAnimation]
        group.duration = max(moveAnimation.duration, opacityAnimation.duration)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.animateMovementAndOpacityDown()
        }
        textLayer.add(group, forKey: nil)
        CATransaction.commit()
        
    }
    
    
    func animateMovementAndOpacityDown (){
        let moveAnimation = CABasicAnimation(keyPath: "position")
        moveAnimation.fromValue = CGPoint(x: textLayer.position.x, y: textLayer.position.y)
        moveAnimation.toValue = CGPoint(x: textLayer.position.x, y: textLayer.position.y + 60)
        moveAnimation.duration = 2
        moveAnimation.fillMode = .forwards
        moveAnimation.isRemovedOnCompletion = false
        moveAnimation.beginTime = CACurrentMediaTime()
        textLayer.add(moveAnimation, forKey: nil)
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0
        opacityAnimation.duration = 2
        opacityAnimation.fillMode = .forwards
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.beginTime = CACurrentMediaTime()
        textLayer.add(opacityAnimation, forKey: nil)
        
        let group = CAAnimationGroup()
        group.animations = [moveAnimation, opacityAnimation]
        group.duration = max(moveAnimation.duration, opacityAnimation.duration)
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.animateMovementAndOpacity()
        }
        textLayer.add(group, forKey: nil)
        CATransaction.commit()
        
    }
    
}
