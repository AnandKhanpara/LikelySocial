//
//  LikelyEmoji.swift
//  Likely
//
//  Created by Anand Khanpara on 17/03/2020.
//  Copyright © 2020 Anand Khanpara. All rights reserved.
//

import Foundation
import UIKit

public final class LikelyEmoji: UIView {
    
    var indexTag:Int = 0
    var image:UIImage?
    
    init(image:UIImage? = nil, tag:Int = 0) {
        super.init(frame: CGRect())
        self.clipsToBounds = true
        self.backgroundColor = .red
        self.indexTag = tag
        self.image = image
        let imgViewEmoji = UIImageView(image: image)
        imgViewEmoji.translatesAutoresizingMaskIntoConstraints = false
        imgViewEmoji.backgroundColor = .red
        imgViewEmoji.contentMode = .scaleToFill
        imgViewEmoji.clipsToBounds = true
        self.addSubview(imgViewEmoji)
        
        imgViewEmoji.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imgViewEmoji.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        imgViewEmoji.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        imgViewEmoji.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

