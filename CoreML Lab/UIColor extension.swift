//
//  UIColor extension.swift
// CoreML Labx
//
//  Created by Chuck Deerinck on 7/18/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import UIKit

infix operator ≅

extension UIColor {
    static func ≅ (lhs:UIColor, rhs:UIColor) -> Bool {
        let tolerance:CGFloat = 0.05
        var lhsRed:CGFloat=0, lhsGreen:CGFloat=0, lhsBlue:CGFloat=0, lhsAlpha:CGFloat=0
        lhs.getRed(&lhsRed, green: &lhsGreen, blue: &lhsBlue, alpha: &lhsAlpha)
        var rhsRed:CGFloat=0, rhsGreen:CGFloat=0, rhsBlue:CGFloat=0, rhsAlpha:CGFloat=0
        rhs.getRed(&rhsRed, green: &rhsGreen, blue: &rhsBlue, alpha: &rhsAlpha)
        //print()
        //print (lhs, rhs, (abs(lhsRed - rhsRed) < tolerance) && (abs(lhsGreen - rhsGreen) < tolerance) && (abs(lhsBlue - rhsBlue) < tolerance) && (abs(lhsAlpha - rhsAlpha) < tolerance))
        //print("red=", abs(lhsRed - rhsRed), "green=", abs(lhsGreen - rhsGreen),"blue=",abs(lhsBlue - rhsBlue),"alpha",abs(lhsAlpha - rhsAlpha))
        return (abs(lhsRed - rhsRed) < tolerance) && (abs(lhsGreen - rhsGreen) < tolerance) && (abs(lhsBlue - rhsBlue) < tolerance) && (abs(lhsAlpha - rhsAlpha) < tolerance)
    }
}
