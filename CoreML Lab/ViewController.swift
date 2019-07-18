//
//  ViewController.swift
//  CoreML Lab
//
//  Created by Chuck Deerinck on 7/16/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var palletView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cmlView: UIView!
    @IBOutlet weak var buttonView: UIButton!

    let palletColors = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 0.568627451, green: 0.568627451, blue: 0.568627451, alpha: 1), #colorLiteral(red: 0.9864992498, green: 1, blue: 0.9512241515, alpha: 1), #colorLiteral(red: 1, green: 0.05961265719, blue: 0.1276257051, alpha: 1), #colorLiteral(red: 1, green: 0.7286719874, blue: 0.04359729751, alpha: 1),#colorLiteral(red: 0.9325127504, green: 1, blue: 0.05200209895, alpha: 1), #colorLiteral(red: 0.1059519023, green: 1, blue: 0.03446751176, alpha: 1), #colorLiteral(red: 0.03795202452, green: 1, blue: 0.931403104, alpha: 1), #colorLiteral(red: 0.1350431257, green: 0.07769530341, blue: 1, alpha: 1), #colorLiteral(red: 0.9916030796, green: 0.09624674189, blue: 1, alpha: 1)]
    enum colorType { case light; case dark }
    let highlight:[colorType] = [.dark, .dark, .light, .light, .light, .light, .light, .light, .dark, .light]
    var selectedColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
    var lightBorder = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6).cgColor
    var darkBorder = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6).cgColor

    var startLocation:CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawPallet()
    }

    func clearBackground(to toColor: CGColor) {
        UIGraphicsBeginImageContext(imageView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        palletView.image?.draw(in: palletView.bounds)
        context.setFillColor(toColor)
        context.fill(view.bounds)
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    func drawPallet() {
        UIGraphicsBeginImageContext(palletView.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        palletView.image?.draw(in: palletView.bounds)
        let palletWidth = palletView.frame.width / 10
        print()
        for i in 0...9 {
            context.setFillColor(palletColors[i].cgColor)
            context.setStrokeColor(palletColors[i].cgColor)
            context.fill(CGRect(x: CGFloat(i)*palletWidth, y: 0, width: palletWidth, height: 32 ))
            if palletColors[i].cgColor == selectedColor {
                if highlight[i] == .dark { context.setStrokeColor(lightBorder) } else { context.setStrokeColor(darkBorder) }
                context.stroke(CGRect(x: CGFloat(i)*palletWidth, y: 0, width: palletWidth, height: 32 ), width: 5.0)
            }
        }
        palletView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    @IBAction func palletTap(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let touchLocation = sender.location(in: palletView)
            let palletWidth = palletView.frame.width / 10
            let palletIndex = touchLocation.x / palletWidth
            selectedColor = palletColors[Int(palletIndex)].cgColor
            drawPallet()
        }
    }

    @IBAction func palletLongTap(_ sender: UILongPressGestureRecognizer) {
        let touchLocation = sender.location(in: palletView)
        let palletWidth = palletView.frame.width / 10
        let palletIndex = touchLocation.x / palletWidth
        clearBackground(to: palletColors[Int(palletIndex)].cgColor)
    }

    @IBAction func imageDraw(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            startLocation = sender.location(in: imageView)
        }
        if sender.state == .ended || sender.state == .changed {
            UIGraphicsBeginImageContext(imageView.frame.size)
            guard let context = UIGraphicsGetCurrentContext() else { return }
            imageView.image?.draw(in: imageView.bounds)
            context.setShouldAntialias(false)
            context.setStrokeColor(selectedColor)
            context.setLineWidth(10.0)
            context.setLineCap(.round)
            context.move(to: startLocation!)
            context.addLine(to: sender.location(in: imageView))
            context.strokePath()
            //context.strokeLineSegments(between: [startLocation!,sender.location(in: imageView)])
            startLocation = sender.location(in: imageView)
            imageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
        }
    }
    
    @IBAction func imageFloodFill(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            let touchLocation = sender.location(in: imageView)
            if let newImage = floodFill(image: imageView.image!, point: touchLocation, color: UIColor(cgColor: selectedColor)) {
                imageView.image = newImage
            }
        }
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        //print(sender.titleForSegment(at: sender.selectedSegmentIndex))
        switch sender.selectedSegmentIndex {
        case 0:
            buttonView.setTitle("Paste from Clipboard", for: .normal)
            palletView.isHidden = false
            imageView.isHidden = false
            cmlView.isHidden = true
        case 1:
            buttonView.setTitle("settings...", for: .normal)
            palletView.isHidden = true
            imageView.isHidden = true
            cmlView.isHidden = true
        case 2:
            buttonView.setTitle("core ml...", for: .normal)
            palletView.isHidden = true
            imageView.isHidden = true
            cmlView.isHidden = false
        default:
            buttonView.setTitle("how did this happen", for: .normal)
        }
    }

    func startModel() {


    }

}

