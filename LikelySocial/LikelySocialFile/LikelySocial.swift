//
//  LikelySocial.swift
//  Likely
//
//  Created by Anand Khanpara on 17/03/2020.
//  Copyright © 2020 Anand Khanpara. All rights reserved.
//

import Foundation
import UIKit

public final class LikelySocial: NSObject {
    
    public final class func add(emojis arrEmoji:[LikelyEmoji], size likelySize:LikelySize = .normal, delegate:LikelySocialDelegate? = nil, superView:UIView? = nil, click location:CGPoint? = nil, isScrollAvailableInVertical:Bool = false, isScrollAvailableInHorizontal:Bool = false)  {
        let likelyView = LikelyView(arrLikelyEmoji: arrEmoji, size: likelySize, delegate: delegate)
        let superView = self.superView(view: superView)
        if let location = location {
            let size = self.likeyViewSize(numberOfEmoji: arrEmoji.count, likelySize: likelySize)
            self.setUpLocation(superView, location, isScrollAvailableInVertical, isScrollAvailableInHorizontal, size) { frame, center in
                likelyView.clickLocation = location
                likelyView.frame = frame
                likelyView.center = center
                superView.addSubview(likelyView)
            }
        }else {
            superView.addSubview(likelyView)
            likelyView.translatesAutoresizingMaskIntoConstraints = false
            likelyView.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: 0).isActive = true
            likelyView.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: 0).isActive = true
        }
    }
    
    class func superView(view:UIView?) -> UIView {
        var superView = UIView()
        if let view = view {
            superView = view
        }else {
            superView = UIApplication.shared.windows.first ?? UIView()
        }
        return superView
    }
   
    class func likeyViewSize(numberOfEmoji:Int, likelySize:LikelySize) -> CGSize {
        let height = likelySize.rawValue + 10
        let widht = ((likelySize.rawValue * CGFloat(numberOfEmoji)) + (CGFloat(numberOfEmoji - 1) * likelySize.spacing()) + 10)
        return CGSize(width: widht, height: height)
    }
    
    class func setUpLocation(_ superView:UIView, _ location:CGPoint, _ isScrollAvailableInVertical:Bool, _ isScrollAvailableInHorizontal:Bool, _ size:CGSize, comlition : (CGRect, CGPoint) -> ())  {
        
        func locationX(_ superView:UIView, _ location:CGPoint) -> CGFloat {
            return location.x
        }
        
        func locationY(_ superView:UIView, _ location:CGPoint) -> CGFloat {
            let minY = superView.frame.minX
            let placePositionY = location.y - (size.height * 2)
            return placePositionY > minY ? (location.y - size.height) : (location.y + size.height)
        }
        
        if isScrollAvailableInVertical == true && isScrollAvailableInHorizontal == false {
            let midX = superView.frame.midX
            let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            let center = CGPoint(x: midX, y: locationY(superView, location))
            comlition(frame, center)
        }else if isScrollAvailableInVertical == false && isScrollAvailableInHorizontal == true {
            let midY = superView.frame.midY
            let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            let center = CGPoint(x: locationX(superView, location), y: midY)
            comlition(frame, center)
        }
    }
}
