//
//  cgPoint.swift
// CoreML Labx
//
//  Created by Chuck Deerinck on 7/16/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import CoreGraphics
import UIKit

extension CGPoint {
    func distance(to p:CGPoint) -> CGFloat {
        return hypot(x - p.x, y - p.y)
    }
}

