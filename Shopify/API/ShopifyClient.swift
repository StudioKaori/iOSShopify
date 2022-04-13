//
//  ShopifyClient.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-13.
//

import UIKit
import Buy

class ShopifyClient: NSObject {
    
    // Shopify storefront API doc: See 'Query' https://shopify.dev/api/storefront/2022-04/objects/Shop#fields
    static let client = Graph.Client(
        shopDomain: KeyManager().getValue(key: "shopDomain") as! String,
        apiKey:     KeyManager().getValue(key: "apiKey") as! String
    )
    
//    static func getShopInfo(completion: @escaping(productsResult)->Void) {
//
//    }
    
    static func getShopInfo() {
        //static func getShopInfo(completion: @escaping(ShopInfoResult)->Void) {
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
            
            guard let data = response else {
                print("Json data error in getShopInfo")
                return
            }
            
            let shopInfo: ShopInfo = ShopInfo(name: data.shop.name)
            
            print("Shop info graphQL: ", data)
            print("Shop info: ", shopInfo)
            

        }
        task.resume()
    }
    
    static func getProducts(numbersOfProducts: Int32) {
                // products information
                // https://shopify.dev/api/storefront/2022-04/queries/products
                // product field : https://shopify.dev/api/storefront/2022-04/objects/Product#fields
                let productsQuery = Storefront.buildQuery { $0
                    .products(first: numbersOfProducts) { $0
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
                    
                    // Unwrap response data
                    guard let jsonData = response else {
                        print("jsonData error in getProductInfor")
                        return
                    }
        
                    print("hi", type(of: jsonData))
                    print(jsonData.products)
                }
                productsTask.resume()
                // End of products information
    }
    
    struct ShopInfoResult: Codable{
        var list: [ShopInfo]
    }
    
    struct ShopInfo: Codable{
        var name: String
        //var moneyFormat: String
    }
}
