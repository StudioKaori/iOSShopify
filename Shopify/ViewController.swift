//
//  ViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-11.
//

import UIKit
import Buy

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    @IBOutlet var productCollectionView: UICollectionView!
    
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
            
        }

    }
    
    // collection view delegate methods
    // return numbers of images to generate the cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    // set contents to each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a cell object
        let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath)
        
        // tag is set in storyboard
        if let productImage = cell.viewWithTag(1) as? UIImageView {
            productImage.image = UIImage(url: products[indexPath.row].images[0])
        }
        
        if let productTitle = cell.viewWithTag(2) as? UILabel {
            productTitle.text = products[indexPath.row].title
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spaceForCells: CGFloat = 3
        let cellWidth: CGFloat = (self.view.bounds.width / 2) - (spaceForCells / 2)
        let cellHeight: CGFloat = (cellWidth * 235 / 156)
        return CGSize(width: cellWidth, height: cellHeight)
    }

//    // return the numbers of products for generationg cells
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return products.count
//    }
//
//    // fill each cells with weather forecast data
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = productsTableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
//
//        let productImage = cell.viewWithTag(1) as? UIImageView
//        productImage?.image = UIImage(url: products[indexPath.row].images[0])
//
//        let productTitle = cell.viewWithTag(2) as? UILabel
//        productTitle?.text = products[indexPath.row].title
//
//
////        let productPrice = cell.viewWithTag(3) as? UILabel
////        productPrice?.text = products[indexPath.row].price
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }


}

