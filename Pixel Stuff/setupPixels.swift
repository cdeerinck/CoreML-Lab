//
//  setupPixel
// CoreML Labx
//
//  Created by Chuck Deerinck on 7/16/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

func setupPixel(in image: UIImage) -> (pointer:UnsafeMutablePointer<RGBA32>?, context:CGContext?) {
    guard let inputCGImage = image.cgImage else {
        print("unable to get cgImage")
        return (nil, nil)
    }
    let colorSpace       = CGColorSpaceCreateDeviceRGB()
    let width            = inputCGImage.width
    let height           = inputCGImage.height
    let bytesPerPixel    = 4
    let bitsPerComponent = 8
    let bytesPerRow      = bytesPerPixel * width
    let bitmapInfo       = RGBA32.bitmapInfo

    guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo) else {
        print("unable to create context")
        return (nil, nil)
    }
    context.draw(inputCGImage, in: CGRect(x: 0, y: 0, width: width, height: height))

    guard let buffer = context.data else {
        print("unable to get context data")
        return (nil, nil)
    }

    return (buffer.bindMemory(to: RGBA32.self, capacity: width * height), context)
}
