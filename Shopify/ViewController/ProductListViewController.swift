//
//  ViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-11.
//

import UIKit
import Buy
import RxSwift
import RxCocoa

class ProductListViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // MARK: - Properties
    
    @IBOutlet var productCollectionView: UICollectionView!
    
    var products: [Product] = []
    
    var activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tilesCollectionViewFlowLayout = TilesCollectionViewFlowLayout()
        productCollectionView.collectionViewLayout = tilesCollectionViewFlowLayout
        
        // activityIndicator
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.color = .black
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
    }
    
    // viewWillAppear will notify before the view is about to be added to hierarchy
    override func viewWillAppear(_ animated: Bool) {
        ShopifyClient.getShopInfo()

        ShopifyClient.getProducts(numbersOfProducts: 25) { (result) in
            //print("result: ", result)
            self.products = result
            
            // UI change should be executed in the main thread
            DispatchQueue.main.async {
                self.productCollectionView.reloadData()
            }
            
            // Stop activityIndicatorView
            self.activityIndicatorView.stopAnimating()
            
        }
        
        // show navigationbar
        self.navigationController!.setNavigationBarHidden(false, animated: false)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productDetailViewController = segue.destination as? ProductDetailViewController {
            productDetailViewController.product = sender as? Product
        }
    }
    
    // MARK: -  collection view delegate methods
    // return numbers of images to generate the cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProductlistToDetail", sender: products[indexPath.row])
    }
    
    // set contents to each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a cell object
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath)
        
        // tag is set in storyboard
        if let productImage = cell.viewWithTag(1) as? UIImageView {
            productImage.image = products[indexPath.row].images[0]
        }
        
        if let productTitle = cell.viewWithTag(2) as? UILabel {
            productTitle.text = products[indexPath.row].title
        }
        
        if let productPrice = cell.viewWithTag(3) as? UILabel {
            productPrice.text = "$ \(products[indexPath.row].price)"
        }
        
        return cell
    }

}

