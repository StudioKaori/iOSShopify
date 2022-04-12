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
        // Shopify storefront API doc: See 'Query' https://shopify.dev/api/storefront/2022-04/objects/Shop#fields

        let client = Graph.Client(
            shopDomain: KeyManager().getValue(key: "shopDomain") as! String,
            apiKey:     KeyManager().getValue(key: "apiKey") as! String
        )
        
 
        // Shop information
        let query = Storefront.buildQuery { $0
            .shop { $0
                .name()
                .moneyFormat()
                .refundPolicy { $0
                    .title()
                    .url()
                }
            }
        }

        let task = client.queryGraphWith(query) { response, error in
            let name         = response?.shop.name
            //let currencyCode = response?.shop.currencyCode
            let moneyFormat  = response?.shop.moneyFormat
            
            print(name)
            print(moneyFormat)
        }
        task.resume()
        // End of shop information
        
        // products information
        // https://shopify.dev/api/storefront/2022-04/queries/products
        // product field : https://shopify.dev/api/storefront/2022-04/objects/Product#fields
        let productsQuery = Storefront.buildQuery { $0
            .products(first: 25) { $0
                .edges { $0
                .node { $0
                    .handle()
                    .title()
                    .description()
                    .images(first: 5) { $0
                        .edges { $0
                            .node { $0
                                .url()
                            }
                        }
                    }
                    .priceRange { $0
                        .maxVariantPrice { $0
                            .amount()
                            .currencyCode()
                        }
                        .minVariantPrice{ $0
                            .amount()
                            .currencyCode()
                        }
                    }
                }
                }
            }
        }

        let productsTask = client.queryGraphWith(productsQuery) { response, error in
            let response         = response

            print(response)
        }
        productsTask.resume()
        // End of products information
        
        
    }


}

