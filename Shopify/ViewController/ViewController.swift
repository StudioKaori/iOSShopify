//
//  ViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-11.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var productListButton: UIButton!
    
    @IBOutlet weak var heroScrollView: UIScrollView! {
        didSet {
            heroScrollView.delegate = self
            heroScrollView.isPagingEnabled = true
            heroScrollView.showsHorizontalScrollIndicator = false
            heroScrollView.showsVerticalScrollIndicator = false
            // Fix the scroll direction
            heroScrollView.isDirectionalLockEnabled = true
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

