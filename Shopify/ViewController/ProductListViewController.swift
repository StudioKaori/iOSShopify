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

class ProductListViewController: UIViewController {
    // MARK: - Properties
    
    @IBOutlet var productCollectionView: UICollectionView!
    
    var products: [Product] = []
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .black
        return indicator
    }()
    
    // for RxSwift
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tilesCollectionViewFlowLayout = TilesCollectionViewFlowLayout()
        productCollectionView.collectionViewLayout = tilesCollectionViewFlowLayout
        
        // activityIndicator
        activityIndicatorView.center = view.center
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        bindCollectionData()
        
    }
    
    // viewWillAppear will notify before the view is about to be added to hierarchy
    override func viewWillAppear(_ animated: Bool) {
        //ShopifyClient.getShopInfo()
        
        // show navigationbar
        self.navigationController!.setNavigationBarHidden(false, animated: false)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let productDetailViewController = segue.destination as? ProductDetailViewController {
            productDetailViewController.product = sender as? Product
        }
    }
    
    
    // MARK: - Bind Collection Data
    func bindCollectionData() {
        
        // Bind items to table
        ShopifyClient.shared.items.bind(to: productCollectionView.rx.items(
            cellIdentifier: "ProductCell",
            cellType: UICollectionViewCell.self)
        ) { row, productModel, cell in
            if let productTitle = cell.viewWithTag(2) as? UILabel {
                productTitle.text = productModel.title
            }
            
            if let productImage = cell.viewWithTag(1) as? UIImageView {
                productImage.image = productModel.images[0]
            }
            
            if let productPrice = cell.viewWithTag(3) as? UILabel {
                productPrice.text = "$ \(productModel.price)"
            }
        }.disposed(by: disposeBag)
        
        // bind a model selected handler, when it's clicked
        productCollectionView.rx.modelSelected(Product.self).bind { product in
            print("bind : \(product.title)")
        }.disposed(by: disposeBag)
        
        // Fetch items
        ShopifyClient.shared.fetchProducts(numbersOfProducts: 25, completion: { [weak self] _ in
            self?.activityIndicatorView.stopAnimating()
        })
    }
    
}

