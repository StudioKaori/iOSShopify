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
    
    var heros: [Hero] = []
    
    var hero1: Hero = Hero(
        title: "Make Up Inspiration",
        image: UIImage(named: "hero1.gif")!,
        buttonLabel: "See products",
        nextViewController: ProductListViewController(),
        nextStoryBoardId: "productListViewController"
    )
    
    var hero2: Hero = Hero(
        title: "Virtual Fitting Room",
        image: UIImage(named: "hero2.jpg")!,
        buttonLabel: "Go Fitting Room",
        nextViewController: FittingRoomViewController(),
        nextStoryBoardId: "fittingRoomViewController"
    )
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heros = [hero1, hero2]
        
        setupHeros()

    }
    
    private func setupHeros(){
        heroScrollView.contentSize = CGSize(width: imageWidth * CGFloat(heros.count), height: scrollHight)
        
        for (index, hero) in heros.enumerated() {
            print(hero)
            let view =　UIView()
        }
    }
    

}

