//
//  LikelySocialDelegate.swift
//  LikelySocial Make
//
//  Created by Anand Khanpara on 17/03/2020.
//  Copyright © 2020 Anand Khanpara. All rights reserved.
//

import Foundation
import UIKit

public protocol LikelySocialDelegate {
    func likelySocial(didSelected emojiImage:UIImage?, selected tag:Int)
}
