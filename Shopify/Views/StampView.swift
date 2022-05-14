//
//  StampView.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-17.
//

import UIKit

protocol StampViewDelegate: AnyObject {
    func didToucheStamp(stampView: StampView)
}

class StampView: UIImageView {
    
    let imageSizes: [CGFloat] = [0.7, 1.0, 1.5]
    var currentImageSizeIndex: Int = 1
    weak var delegate: StampViewDelegate?
    
    
    // Add double tap gesture for resizing the stamp
    // executed when it's instanciate in super view
    override func didMoveToWindow() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.superview?.bringSubviewToFront(self)
        
        // set self to the focusedStamp in FittingroomVC
        delegate?.didToucheStamp(stampView: self)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        
//        let dx = touch.location(in: self.superview).x - touch.previousLocation(in: self.superview).x
//        let dy = touch.location(in: self.superview).y - touch.previousLocation(in: self.superview).y
//        self.center = CGPoint(x: self.center.x + dx, y: self.center.y + dy)
        
        let dx = touch.location(in: self.superview).x - touch.previousLocation(in: self.superview).x
        let dy = touch.location(in: self.superview).y - touch.previousLocation(in: self.superview).y
        self.center = CGPoint(x: self.center.x + dx, y: self.center.y + dy)
    }
    
    @objc func doubleTapped() {
        currentImageSizeIndex += 1
        if currentImageSizeIndex + 1 > imageSizes.count {
            currentImageSizeIndex = 0
        }
        let size:CGFloat = imageSizes[currentImageSizeIndex]
        self.transform = CGAffineTransform(scaleX: size, y: size)
        
    }
}
