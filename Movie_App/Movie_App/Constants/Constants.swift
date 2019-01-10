//
//  Constants.swift
//  Movie_App
//
//  Created by MAC110 on 1/10/19.
//  Copyright © 2019 MAC110. All rights reserved.
//

import UIKit

let IS_IPHONE_5             = 568
let IS_IPHONE_6             = 667

let IPHONE6_PLUS_WIDTH      = 414.0
let IPHONE6_PLUS_HEIGHT     = 736.0
let IPHONE6_WIDTH       = 375.0
let IPHONE6_HEIGHT      = 667.0
let Screen                   = UIScreen.main.bounds.size

var SAFE_AREA_NOTCH_INSET: CGFloat{
    if #available(iOS 11.0, *) {
        let inset = UIApplication.shared.keyWindow?.safeAreaInsets
        return (inset?.top ?? 0) +  (inset?.bottom ?? 0)
    }else{
        return 0
    }
}

var SAFE_AREA_NOTCH_INSET_TOP: CGFloat{
    if #available(iOS 11.0, *) {
        let inset = UIApplication.shared.keyWindow?.safeAreaInsets
        return (inset?.top ?? 0)
    }else{
        return 0
    }
}
