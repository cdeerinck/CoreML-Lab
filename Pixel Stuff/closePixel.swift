//
//  closePixel.swift
//  CoreML Lab
//
//  Created by Chuck Deerinck on 7/16/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import CoreGraphics
import UIKit

func closePixel(in image:UIImage, context:CGContext ) -> UIImage {
    let outputCGImage = context.makeImage()!
    let outputImage = UIImage(cgImage: outputCGImage, scale: image.scale, orientation: image.imageOrientation)
    return outputImage
}
