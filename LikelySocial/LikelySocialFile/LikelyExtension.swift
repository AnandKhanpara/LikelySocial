//
//  LikelyExtension.swift
//  Likely
//
//  Created by Anand Khanpara on 17/03/2020.
//  Copyright © 2020 Anand Khanpara. All rights reserved.
//

import Foundation
import UIKit

public enum LikelySize:CGFloat {
    
    case small = 30.0
    case normal = 40.0
    case large = 50.0
    
    func spacing() -> CGFloat {
        switch self {
        case .small: return 5
        case .normal: return 5
        case .large: return 5
        }
    }
}
