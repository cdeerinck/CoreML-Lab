//
//  floodFill.swift
// CoreML Labx
//
//  Created by Chuck Deerinck on 7/16/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//
import UIKit
import CoreGraphics

func floodFill(image:UIImage, point:CGPoint, color:UIColor) -> UIImage? {
    let (pointer, context) = setupPixel(in: image)
    if pointer != nil && context != nil {
        let background = getPixel(pixelBuffer: pointer!, context: context!, size: image.size, point: point)
        if background == color { return nil }
        fill(pointer!, context!, image.size, point, background, color)
        return closePixel(in: image, context: context!)
    }
    return nil
}

func fill(_ pointer:UnsafeMutablePointer<RGBA32>, _ context:CGContext, _ size:CGSize, _ point:CGPoint, _ background:UIColor, _ color:UIColor) {
    if !(getPixel(pixelBuffer: pointer, context: context, size: size, point: point) ≅ background) {
        return
    }

    //scan right
    var x = point.x
    let y = point.y
    while x < size.width && (getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y)) ≅ background) {
        putPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y), color: color)
        x += 1
    }
    //scan left
    x = point.x - 1
    while x > 0 && (getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y)) ≅ background) {
        putPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y), color: color)
        x -= 1
    }
    //test for new scanline above right
    x = point.x
    if y > 0 {
        while x < size.width && (getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y)) ≅ color) {
            if getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y-1)) ≅ background {
                fill(pointer, context, size, CGPoint(x:x, y:y-1), background, color)
                }
            x += 1
        }
        x = point.x - 1
        //test for new scanline above left
        while x > 0 && (getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y)) ≅ color) {
            if getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y-1)) ≅ background {
                fill(pointer, context, size, CGPoint(x:x, y:y-1), background, color)
            }
            x -= 1
        }
    }
    //test for new scanline below right
    x = point.x
    if y < size.height - 1 {
        while x < size.width && (getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y)) ≅ color) {
            if getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y+1)) ≅ background {
                fill(pointer, context, size, CGPoint(x:x, y:y+1), background, color)
            }
            x += 1
        }
        x = point.x - 1
        //test for new scanline below left
        while x > 0 && (getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y)) ≅ color) {
            if getPixel(pixelBuffer: pointer, context: context, size: size, point: CGPoint(x:x, y:y+1)) ≅ background {
                fill(pointer, context, size, CGPoint(x:x, y:y+1), background, color)
            }
            x -= 1
        }
    }
}
