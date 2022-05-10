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
    
    @IBOutlet weak var heroPageControl: UIPageControl! {
        didSet {
            heroPageControl.isUserInteractionEnabled = false
        }
    }
    
    private let scrollHight: CGFloat = UIScreen.main.bounds.height
    private let imageWidth: CGFloat = UIScreen.main.bounds.width
    
    
    // hero information
    struct Hero{
        var title: String
        var image: UIImage
        var buttonLabel: String
        var nextViewController: AnyObject
        var nextStoryBoardId: String
    }
    
    var hero1: Hero = Hero(
        title: "Make Up Inspiration", image: <#T##UIImage#>, buttonLabel: <#T##String#>, nextViewController: <#T##AnyObject#>, nextStoryBoardId: <#T##String#>
    )
    
    var heros: [Hero] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}

