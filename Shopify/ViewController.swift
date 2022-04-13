//
//  ViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-11.
//

import UIKit
import Buy

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ShopifyClient.getShopInfo()
        ShopifyClient.getProducts(numbersOfProducts: 25)
    }


}

