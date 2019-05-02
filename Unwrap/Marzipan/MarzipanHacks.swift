//
//  MarzipanHacks.swift
//  Unwrap
//
//  Created by Julian Schiavo on 14/3/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

// MARZIPAN: Hacks
#if MARZIPAN

// Fix missing selectors on NSFont
extension NSObject {
    @objc func _bodyLeading() -> Double {
        return 0
    }

    @objc func isSystemFont() -> Bool {
        return false
    }

    @objc func _fontAdjustedForContentSizeCategoryCompatible(withTraitCollection arg1: Any?) -> Any? {
        return self
    }
}

// Fix center text alignment
@objc enum NSTextAlignment: Int {
    case left = 0 // Visually left aligned
    #if TARGET_OS_IPHONE
    case center = 1 // Visually centered
    case right = 2 // Visually right aligned
    #else
    case right = 1 // Visually right aligned
    case center = 2 // Visually centered
    #endif
    case justified = 3 // Fully-justified. The last line in a paragraph is natural-aligned
    case natural = 4 // Indicates the default alignment for script
}
#endif
