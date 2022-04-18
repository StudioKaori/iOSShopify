//
//  FittingRoomViewController.swift
//  Shopify
//
//  Created by Kaori Persson on 2022-04-18.
//

import UIKit

class FittingRoomViewController: UIViewController, UIImagePickerController, StampSelectViewControllerDelegate {
    
    @IBOutlet var stampBaseView: StampBaseView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let stampSelectVC = segue.destination as? StampSelectViewController {
            stampSelectVC.delegate = self
        }
    }
    
    @IBAction func cameraTapped(sender: UIButton) {
        
    }
    
    @IBAction func stampTapped(sender: UIButton) {
        performSegue(withIdentifier: "FittingRoomToStamp", sender: nil)
    }
    
    @IBAction func deleteTapped(sender: UIButton) {
        stampBaseView.deleteStamp()
    }
    
    @IBAction func saveTapped(){
        
    }


}
