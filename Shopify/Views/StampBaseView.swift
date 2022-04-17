//
//  StampBaseView.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-17.
//

import UIKit

class StampView: UIView {
    @IBOutlet var backgroundImageView: UIImageView!
    
    func setBackgroundImage(image: UIImage) {
        backgroundImageView.image = image
    }
    
    func addStamp(stampImage: UIImage){
        let size = 100
        let stampView = StampView()
    }
}
