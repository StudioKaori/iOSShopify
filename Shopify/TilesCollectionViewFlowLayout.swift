//
//  TilesCollectionViewFlowLayout.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-14.
//

import UIKit

class TilesCollectionViewFlowLayout: UICollectionViewFlowLayout {

//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
    
    @IBInspectable var numberOfColumns: Int = 4 {
        didSet {
            invalidateLayout()
        }
    }
    
    @IBInspectable var heightRatio: CGFloat = 1 {
        didSet {
            invalidateLayout()
        }
    }
    
    private func updateItemSize() {
        guard let collectionView = collectionView else {
            return
        }
        let isWide = collectionView.traitCollection.horizontalSizeClass != .compact || collectionView.traitCollection.verticalSizeClass == .compact
        let columns = CGFloat(isWide ? numberOfColumns : numberOfColumns / 2)
        let margins = collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + sectionInset.left + sectionInset.right
        let spacings = minimumLineSpacing * (columns - 1)
        let width = (collectionView.bounds.width - margins - spacings - 5) / columns
        let height = width * heightRatio
        itemSize = CGSize(width: width, height: height)
    }
    
    override func prepare() {
        super.prepare()
        updateItemSize()
    }
}
