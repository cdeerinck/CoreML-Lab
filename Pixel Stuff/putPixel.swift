//
//  putPixel.swift
//  CoreML Lab
//
//  Created by Chuck Deerinck on 7/16/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import CoreGraphics
import UIKit

func putPixel(pixelBuffer:UnsafeMutablePointer<RGBA32>, context:CGContext, size:CGSize, point: CGPoint, color: UIColor ) {
    var red:CGFloat=0, green:CGFloat=0, blue:CGFloat=0, alpha:CGFloat = 0
    color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    pixelBuffer[Int(point.y) * Int(size.width) + Int(point.x)] = RGBA32(red: UInt8(red*255), green: UInt8(green*255), blue: UInt8(blue*255), alpha: UInt8(alpha*255))
    return
}
