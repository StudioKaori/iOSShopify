//
//  StampSelectViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-17.
//

protocol StampSelectViewControllerDelegate: AnyObject {
    func didSelectStamp(stampImage: UIImage)
}

import UIKit

class StampSelectViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var stampImages = [UIImage]()
    
    @IBOutlet var stampCollectionView: UICollectionView!
    
    weak var delegate: StampSelectViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tilesCollectionViewFlowLayout = TilesCollectionViewFlowLayout()
        stampCollectionView.collectionViewLayout = tilesCollectionViewFlowLayout

        for i in 1...2 {
            if let image = UIImage(named: "dress\(i).png"){
                stampImages.append(image)
            }
        }
     }
    
    @IBAction func close(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // collection view delegate methods
    // return numbers of images to generate the cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stampImages.count
    }
    
    // set contents to each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampCell", for: indexPath)
        
        if let stampImageView = cell.viewWithTag(1) as? UIImageView {
            stampImageView.image = stampImages[indexPath.row]
        }
        
        return cell
    }
    
    // Pass picked image from picker and set it in backgournd
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectStamp(stampImage: stampImages[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }

}
