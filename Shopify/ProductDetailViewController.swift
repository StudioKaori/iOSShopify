//
//  ProductDetailViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-15.
//

import UIKit

class ProductDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var product: Product?
    
    @IBOutlet weak var productImagesScrollView: UIScrollView! {
        didSet {
            productImagesScrollView.delegate = self
            productImagesScrollView.isPagingEnabled = true
            productImagesScrollView.showsHorizontalScrollIndicator = false
            // Fix the scroll direction
            productImagesScrollView.isDirectionalLockEnabled = true
        }
    }
    
    @IBOutlet weak var productImagesPageControll: UIPageControl! {
        didSet {
            productImagesPageControll.isUserInteractionEnabled = false
        }
    }
    
    private let scrollHight: CGFloat = UIScreen.main.bounds.height
    private let imageWidth: CGFloat = UIScreen.main.bounds.width
    


    override func viewDidLoad() {
        super.viewDidLoad()
        print("productDetail: ", product)
        
        setupImages()
    }
    
    private func setupImages() {
        
        guard let images = product?.images else {
            print("Cannot convert product images")
            return
        }
        
        productImagesScrollView.contentSize = CGSize(width: imageWidth * CGFloat(images.count),
                                                     height: scrollHight)
        
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: imageWidth * CGFloat(index), y: 0, width: imageWidth, height: scrollHight))
            //let imageView = UIImageView()
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            productImagesScrollView.addSubview(imageView)
        }
        productImagesPageControll.numberOfPages = images.count
        productImagesPageControll.currentPage = 0

    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        productImagesPageControll.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
    }
}
