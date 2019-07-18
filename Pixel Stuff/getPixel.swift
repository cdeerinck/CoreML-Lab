//
//  getPixel.swift
//  CoreML Lab
//
//  Created by Chuck Deerinck on 7/16/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import UIKit

func getPixel(pixelBuffer:UnsafeMutablePointer<RGBA32>, context:CGContext, size:CGSize, point: CGPoint) -> UIColor {
    let rgba32 = pixelBuffer[Int(point.y) * Int(size.width) + Int(point.x)]
    return UIColor(red: CGFloat(rgba32.redComponent)/255, green: CGFloat(rgba32.greenComponent)/255, blue: CGFloat(rgba32.blueComponent)/255, alpha: CGFloat(rgba32.alphaComponent)/255)
}
