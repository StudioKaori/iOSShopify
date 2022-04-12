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
        // API Key
                if let APIKEY = KeyManager().getValue(key: "shopDomain") as? String {
                    print(APIKEY)
                }
        let client = Graph.Client(
            shopDomain: KeyManager().getValue(key: "shopDomain") as! String,
            apiKey:     KeyManager().getValue(key: "apiKey") as! String
        )
        
 
        // Shop information
        let query = Storefront.buildQuery { $0
            .shop { $0
                .name()
                //.currencyCode()
                .refundPolicy { $0
                    .title()
                    .url()
                }
            }
        }

        let task = client.queryGraphWith(query) { response, error in
            let name         = response?.shop.name
            //let currencyCode = response?.shop.currencyCode
            //let moneyFormat  = response?.shop.moneyFormat
            
            print(name)
            //print(moneyFormat)
        }
        task.resume()
        // End of shop information
        
        
    }


}

