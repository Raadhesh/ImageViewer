//
//  ViewController.swift
//  ImageViewer
//
//  Created by Craig Grummitt on 22/04/2016.
//  Copyright © 2016 Craig Grummitt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let images = ["CradleMountain.JPG","Laguna69.JPG","PatagoniaSky.JPG"]
    var imageNo = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeLeftGestureRecognizer.numberOfTouchesRequired = 3
        swipeLeftGestureRecognizer.direction = .left
        imageView.addGestureRecognizer(swipeLeftGestureRecognizer)
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRightGestureRecognizer.numberOfTouchesRequired = 3
        swipeRightGestureRecognizer.direction = .right
        imageView.addGestureRecognizer(swipeRightGestureRecognizer)
    }
    @IBAction func handlePan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        imageView.center = CGPoint(x:imageView.center.x + translation.x,y:imageView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
        imageView.transform = imageView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
    @IBAction func handleRotation(_ sender: UIRotationGestureRecognizer) {
        imageView.transform = imageView.transform.rotated(by: sender.rotation)
        sender.rotation = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            imageNo += 1
            if imageNo == images.count {imageNo = 0}
        } else if sender.direction == .right {
            imageNo -= 1
            if imageNo == -1 {imageNo = images.count - 1}
        }
        imageView.image = UIImage(named: images[imageNo])
    }

}
extension ViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
