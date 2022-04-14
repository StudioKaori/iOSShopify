//
//  ViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-11.
//

import UIKit
import Buy

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var productsTableView: UITableView!
    
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
                self.productsTableView.reloadData()
            }
            
        }

    }
    

    // return the numbers of products for generationg cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    // fill each cells with weather forecast data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productsTableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        let productImage = cell.viewWithTag(1) as? UIImageView
        productImage?.image = getImageByUrl(url: products[indexPath.row].images[0])
        
        let productTitle = cell.viewWithTag(2) as? UILabel
        productTitle?.text = products[indexPath.row].title
        
        
//        let productPrice = cell.viewWithTag(3) as? UILabel
//        productPrice?.text = products[indexPath.row].price
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func getImageByUrl(url: URL) -> UIImage{
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
}

