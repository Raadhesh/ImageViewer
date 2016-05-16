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
        swipeLeftGestureRecognizer.direction = .Left
        imageView.addGestureRecognizer(swipeLeftGestureRecognizer)
        
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeRightGestureRecognizer.numberOfTouchesRequired = 3
        swipeRightGestureRecognizer.direction = .Right
        imageView.addGestureRecognizer(swipeRightGestureRecognizer)
    }
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(self.view)
        imageView.center = CGPoint(x:imageView.center.x + translation.x,y:imageView.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    @IBAction func handlePinch(sender: UIPinchGestureRecognizer) {
        imageView.transform = CGAffineTransformScale(imageView.transform,sender.scale, sender.scale)
        sender.scale = 1
    }
    @IBAction func handleRotation(sender: UIRotationGestureRecognizer) {
        imageView.transform = CGAffineTransformRotate(imageView.transform, sender.rotation)
        sender.rotation = 0
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.direction == .Left {
            imageNo += 1
            if imageNo == images.count {imageNo = 0}
        } else if sender.direction == .Right {
            imageNo -= 1
            if imageNo == -1 {imageNo = images.count - 1}
        }
        imageView.image = UIImage(named: images[imageNo])
    }

}
extension ViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
