//
//  ViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-11.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // API Key
                if let APIKEY = KeyManager().getValue(key: "shopDomain") as? String {
                    print(APIKEY)
                }
    }


}

