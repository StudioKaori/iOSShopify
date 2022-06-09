//
//  ShopifyClient.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-13.
//

import UIKit
import Buy
import RxSwift
import RxCocoa

class ShopifyClient: NSObject {
    
    // Make the class singleton
    static let shared = ShopifyClient()
    
    // Shopify storefront API doc: See 'Query' https://shopify.dev/api/storefront/2022-04/objects/Shop#fields
    static let client = Graph.Client(
        shopDomain: KeyManager().getValue(key: "shopDomain") as! String,
        apiKey:     KeyManager().getValue(key: "apiKey") as! String
    )
    
    //    static func getShopInfo(completion: @escaping(productsResult)->Void) {
    //
    //    }
    
    let items = PublishSubject<[Product]>()
    
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
    
    static func getProducts(numbersOfProducts: Int32, completion: @escaping(Array<Product>)->Void){
        var products: [Product] = []
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
            guard let data = response else {
                print("jsonData error in getProductInfor")
                return
            }
            
            for item in data.products.edges {
                
                var images: [UIImage] = []
                for image in item.node.images.edges {
                    let productImage = UIImage(url: image.node.url)
                    images.append(productImage)
                }
                
                let product: Product = Product(
                    title: item.node.title,
                    description: item.node.description,
                    price: item.node.priceRange.maxVariantPrice.amount,
                    images: images,
                    handle: item.node.handle
                )
                products.append(product)
                completion(products)
            }
            
        }
        productsTask.resume()
        
        // End of products information
    }
    
    public func fetchProducts(numbersOfProducts: Int32, completion: @escaping (Bool) -> Void){
        
        var products: [Product] = []
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
        
        let productsTask = ShopifyClient.client.queryGraphWith(productsQuery) { response, error in
            
            // Unwrap response data
            guard let data = response else {
                print("jsonData error in getProductInfor")
                return
            }
            
            for item in data.products.edges {
                
                var images: [UIImage] = []
                for image in item.node.images.edges {
                    let productImage = UIImage(url: image.node.url)
                    images.append(productImage)
                }
                
                let product: Product = Product(
                    title: item.node.title,
                    description: item.node.description,
                    price: item.node.priceRange.maxVariantPrice.amount,
                    images: images,
                    handle: item.node.handle
                )
                products.append(product)
                
            }
            self.items.onNext(products)
            self.items.onCompleted()
            completion(true)
            
        }
        productsTask.resume()
        
        // End of products information
    }
    
}

struct ShopInfo {
    var name: String
    //var moneyFormat: String
}

struct Product{
    var title: String
    var description: String
    var price: Decimal
    var images: [UIImage]
    var handle: String
    
}
