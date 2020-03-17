//
//  LikelyView.swift
//  Likely
//
//  Created by ZerOnes on 17/03/2020.
//  Copyright © 2020 ZerOnes. All rights reserved.
//

import Foundation
import UIKit

class LikelyView: UIView {
    
    var clickLocation = CGPoint()
    var likelySize:LikelySize = .normal
    private var maxTag = 0
    
    init(arrLikelyEmoji arrEmoji:[LikelyEmoji], size likelySize:LikelySize = .normal) {
        super.init(frame: CGRect())
        
        self.likelySize = likelySize
        self.maxTag = arrEmoji.count
        
        arrEmoji.forEach( { $0.layer.cornerRadius = likelySize.rawValue / 2 })
        
        for i in 0..<arrEmoji.count {
            arrEmoji[i].tag = i
            arrEmoji[i].translatesAutoresizingMaskIntoConstraints = false
            arrEmoji[i].widthAnchor.constraint(equalToConstant: likelySize.rawValue ).isActive = true
            arrEmoji[i].heightAnchor.constraint(equalTo: arrEmoji[i].widthAnchor, multiplier: 1.0 / 1.0).isActive = true
        }
        
        let viewBG = UIView()
        viewBG.translatesAutoresizingMaskIntoConstraints = false
        viewBG.backgroundColor = .white
        viewBG.layer.cornerRadius = (likelySize.rawValue + 10) / 2
        self.addSubview(viewBG)
        
        viewBG.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        viewBG.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        viewBG.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        viewBG.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        let stack = UIStackView(arrangedSubviews: arrEmoji)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = likelySize.spacing()
        stack.alignment = .fill
        stack.clipsToBounds = true
        stack.distribution = .fillEqually
        viewBG.addSubview(stack)
        
        stack.topAnchor.constraint(equalTo: viewBG.topAnchor, constant: 5).isActive = true
        stack.leadingAnchor.constraint(equalTo: viewBG.leadingAnchor, constant: 5).isActive = true
        stack.trailingAnchor.constraint(equalTo: viewBG.trailingAnchor, constant: -5).isActive = true
        stack.bottomAnchor.constraint(equalTo: viewBG.bottomAnchor, constant: -5).isActive = true
        
        let long = UILongPressGestureRecognizer(target: self, action: #selector(self.longGesture))
        long.minimumPressDuration = 0
        stack.addGestureRecognizer(long)
        
    }
    
    @objc func longGesture(gesture:UILongPressGestureRecognizer)  {
        switch gesture.state {
        case .began, .changed:
            self.emojiBeganChangedAnimation(gesture)
        case .ended :
            self.emojiEndedAnimation(gesture)
        default:
            break
        }
    }
    
    func emojiBeganChangedAnimation(_ gesture:UILongPressGestureRecognizer) {
        let tag = self.touchLocationViewTag(gesture)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: .curveLinear, animations: {
            gesture.view?.subviews.filter({ $0.tag == tag }).first?.transform = CGAffineTransform(translationX: 0, y: -(self.likelySize.rawValue + 10))
            gesture.view?.subviews.forEach({ if $0.tag != tag { $0.transform = .identity }})
            self.layoutIfNeeded()
        })
    }
    
    func emojiEndedAnimation(_ gesture:UILongPressGestureRecognizer) {
        let tag = self.touchLocationViewTag(gesture)
        var viewEmojo:LikelyEmoji?
        let center = self.center
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: .curveLinear, animations: {
            if 0 <= tag && tag < self.maxTag {
                gesture.view?.subviews.forEach({
                    if $0.tag == tag {
                        if let emoji = $0 as? LikelyEmoji {
                            viewEmojo = emoji
                            $0.transform = .identity
                        }
                    }else {
                        self.frame.size.width = self.likelySize.rawValue + 10
                        self.center = center
                        $0.isHidden = true;
                        $0.transform = CGAffineTransform(scaleX: 0.1, y: 0.1);
                        $0.alpha = 0
                    }
                })
            }else {
                self.alpha = 0
            }
            self.layoutIfNeeded()
        }, completion: { _ in
            if let _ = viewEmojo {
                self.emojiEndedRemoveAnimation(gesture)
            }else {
                self.removeFromSuperview()
            }
        })
    }
    
    func emojiEndedRemoveAnimation(_ gesture:UILongPressGestureRecognizer)  {
        let animation = CAKeyframeAnimation(keyPath: "position")
        let path = UIBezierPath()
        path.move(to: self.center)
        let c1 = CGPoint(x: self.center.x, y: self.center.y - 100)
        let c2 = CGPoint(x: self.clickLocation.x, y: self.clickLocation.y - 100)
        path.addCurve(to: self.clickLocation, controlPoint1: c1, controlPoint2: c2)
        animation.path = path.cgPath
        animation.fillMode = CAMediaTimingFillMode.both
        animation.isRemovedOnCompletion = false
        animation.duration = 0.3
        animation.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeIn)
        self.layer.add(animation, forKey:"trash")
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)
            self.alpha = 0.6
            self.layoutIfNeeded()
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    
    func touchLocationViewTag(_ gesture:UILongPressGestureRecognizer) -> Int {
        let location = gesture.location(in: gesture.view)
        let viewWidht = Int((likelySize.rawValue + (likelySize.spacing() / 2)))
        let viewDistance = Int(round(location.x))
        let tag = viewDistance / viewWidht
        return location.x > 0 ? tag : -1
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
