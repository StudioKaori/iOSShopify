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
    
    var products: [Product]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ShopifyClient.getShopInfo()
        product = ShopifyClient.getProducts(numbersOfProducts: 25)
    }

    // return the numbers of weather forecast for generationg cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

}

