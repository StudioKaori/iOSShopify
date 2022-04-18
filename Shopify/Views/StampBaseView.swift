//
//  StampBaseView.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-17.
//

import UIKit

class StampBaseView: UIView {
    @IBOutlet var backgroundImageView: UIImageView!
    
    func setBackgroundImage(image: UIImage) {
        backgroundImageView.image = image
    }
    
    func addStamp(stampImage: UIImage){
        let size = 100
        let stampView = StampView()
        stampView.image = stampImage
        stampView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        stampView.center = self.center
        stampView.isUserInteractionEnabled = true
        self.addSubview(stampView)
    }
    
    func deleteStamp(){
        if let topStamp = self.subviews.last as? StampView {
            topStamp.removeFromSuperview()
        }
    }
    
    func saveImageWithStamps() {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else {return}
        self.layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return}
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)

        
    }
}
